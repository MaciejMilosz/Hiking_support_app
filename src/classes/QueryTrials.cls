/**
 * Created by mmilo on 10/11/2018.
 */

public with sharing class QueryTrials {
    @InvocableMethod (label='Query Trials')
    public static List<List<Trial__c>> queryTrials(List<String> names){
        Map<Id, Mountains__c> mtMap = new Map<Id, Mountains__c>([Select Id, Name FROM Mountains__c WHERE Name IN :names]);
        List<List<Trial__c>> retList = new List<List<Trial__c>>();
        Map<Id, List<Trial__c>> mtToTrials = new Map<Id, List<Trial__c>>();
        for(Trial__c tr : [SELECT Id, Name, Mountains__c FROM Trial__c WHERE Mountains__c IN :mtMap.keySet()]){
            List<Trial__c> temp = mtToTrials.containsKey(tr.Mountains__c) ? mtToTrials.get(tr.Mountains__c) : new List<Trial__c>();
            temp.add(tr);
            mtToTrials.put(tr.Mountains__c, temp);
        }
        for(List<Trial__c> trl : mtToTrials.values()){
            retList.add(trl);
        }
        return retList;
    }
}