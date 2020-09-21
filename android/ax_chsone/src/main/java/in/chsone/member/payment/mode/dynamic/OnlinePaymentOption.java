package in.chsone.member.payment.mode.dynamic;

import android.app.Activity;

import com.google.gson.JsonSyntaxException;
import com.rg.rahul.networklib.SimpleRequest;
import com.rg.rahul.networklib.callback.JSONINetworkEmptyCallback;
import com.singlesignon.common.OfflineApiData;
import com.singlesignon.common.SingleSignApplication;
import com.singlesignon.common.apis.pojo.Company;
import com.singlesignon.common.login.SingleSignAccessInfoPOJO;
import com.singlesignon.common.network.SingleSignApiHandler;
import com.singlesignon.common.profile.UserProfilePojo;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;


/**
 * Created by ₹!houlG on 5/9/19.
 * Futurescape Tech
 * rahul.giradkar@futurescapetech.com
 */
public class OnlinePaymentOption {
    public static OnlinePaymentOption getInstance() {
        return new OnlinePaymentOption();
    }

    public void getOnlinePaymentOption(Activity activity, String unitId, final IOnlinePaymentOption onlinePaymentOption) {
        SingleSignApiHandler singleSignUpNetworkHandler = SingleSignApiHandler.getInstance();
        HashMap<String, String> tokenHash = new HashMap<String, String>();
        UserProfilePojo userProfilePojo = UserProfilePojo.getProfileSync(activity);
        tokenHash.put("access_token", SingleSignAccessInfoPOJO.getAccessToken(activity).access_token);
        tokenHash.put("session_token", userProfilePojo.sessionToken);
        tokenHash.put("username", userProfilePojo.username);
        OfflineApiData offlineApiData = new OfflineApiData(activity);
        Company value = SingleSignApplication.getInstance().defaultCompany.getValue();
        if (value != null) {
            int companyId = value.companyId;
            String[] query = new String[]{String.valueOf(companyId), String.valueOf(unitId)};
            String s = offlineApiData.get("_OnlinePaymentOption", value + "", companyId + "" + unitId + "");
            if (s != null) {
                onSuccessData(s, offlineApiData, value, unitId, onlinePaymentOption);
            } else {
                getDataFromServer(unitId, onlinePaymentOption, singleSignUpNetworkHandler, tokenHash, offlineApiData, value, query);
            }
        }
    }

    private void getDataFromServer(String unitId, IOnlinePaymentOption onlinePaymentOption, SingleSignApiHandler singleSignUpNetworkHandler, HashMap<String, String> tokenHash, OfflineApiData offlineApiData, Company value, String[] query) {
        SimpleRequest vpaOption = singleSignUpNetworkHandler.getVPAOptions(tokenHash, query);
        vpaOption.setResponseCallback(new JSONINetworkEmptyCallback() {

            @Override
            public void networkResponseSuccess(JSONObject jsonResponse) {
                try {
                    onSuccessData(jsonResponse, offlineApiData, value, unitId, onlinePaymentOption);
                } catch (JSONException | JsonSyntaxException e) {
                    e.printStackTrace();
                    onlinePaymentOption.paymentOptionFailed("Interner Server error");
                }
            }

            @Override
            public void networkResponseFailure(JSONObject jsonResponse) {
                try {
                    onlinePaymentOption.paymentOptionFailed(jsonResponse.getString("error"));
                } catch (JSONException e) {
                    e.printStackTrace();
                    onlinePaymentOption.paymentOptionFailed("Internet Server error");
                }
            }

            @Override
            public void networkResponseNetworkError() {
                onlinePaymentOption.paymentOptionFailed("Please turn on your internet connection");
            }
        });
        singleSignUpNetworkHandler.singleTaskExecute(vpaOption);
    }

    private void onSuccessData(JSONObject jsonResponse, OfflineApiData offlineApiData, Company value, String unitId, IOnlinePaymentOption onlinePaymentOption) throws JSONException {
        JSONObject data = jsonResponse.getJSONObject("data");
        /*  OnlineAccount onlineAccount = new Gson().fromJson(data.toString(), OnlineAccount.class);*/
        /*if (!data.isNull("bank_details")  && !data.getJSONObject("bank_details").isNull("bankname")  ) {*/
        offlineApiData.save(jsonResponse.toString(), "_OnlinePaymentOption", value + "", unitId + "");
        onlinePaymentOption.paymentOptionSuccess(data);
        /*}*/
    }

    private void onSuccessData(String jsonResponse, OfflineApiData offlineApiData, Company value, String unitId, IOnlinePaymentOption onlinePaymentOption) {
        try {
            JSONObject data = new JSONObject(jsonResponse).getJSONObject("data");
            /* OnlineAccount onlineAccount = new Gson().fromJson(data.toString(), OnlineAccount.class);*/
            /*  if (!data.isNull("bank_details")  && !data.getJSONObject("bank_details").isNull("bankname")  ) {*/
            offlineApiData.save(jsonResponse, "_OnlinePaymentOption", value + "", unitId + "");
            onlinePaymentOption.paymentOptionSuccess(data);
            /* }*/
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
