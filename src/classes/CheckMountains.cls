/**
 * Created by mmilo on 10/15/2018.
 */

public with sharing class CheckMountains {
    @InvocableMethod (label='Check Mountains')
    public static List<Boolean> checkMountains(List<String> names){
        Map<String, Mountains__c> mtsMap = new Map<String, Mountains__c>();
        for( Mountains__c mt : [SELECT Id, Name, LastModifiedBy, LastModifiedDate FROM Mountains__c WHERE Name IN :names]){
            mtsMap.put(mt.Name, mt);
        }
        List<Boolean> retList = new List<Boolean>();
        for(String n : names){
            if(mtsMap.containsKey(n)){
                retList.add(true);
            }else{
                retList.add(false);
            }
        }
        return retList;
    }
}