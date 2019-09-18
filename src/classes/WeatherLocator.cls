public with sharing class WeatherLocator {

//    static final String APIKEY = '1ed86a7e0c837a75e8969303abce51fa'; //openWeatherMap
    static final String APIKEY = '6d8b17470e90473aa7510820e1c54f14'; //weatherbit

    @AuraEnabled
    public static CityWeather__c getWeather(String city) {

        String weatherAPI = 'https://api.weatherbit.io/v2.0/current?city=' + city + '&key=' + APIKEY;
        System.debug('str: ' + weatherAPI);

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(weatherAPI);
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        CityWeather__c parsedCityWeather = new CityWeather__c();

        if (response.getStatusCode() == 200) {

            System.JSONParser parser = JSON.createParser(response.getBody());
            JSON2ApexWeatherbit smth = (JSON2ApexWeatherbit) System.JSON.deserialize(response.getBody(), JSON2ApexWeatherbit.class);

            parsedCityWeather.Temp__c = smth.data.get(0).temp;
            parsedCityWeather.Country__c = smth.data.get(0).country_code;
            parsedCityWeather.Pressure__c = smth.data.get(0).pres;
            parsedCityWeather.Humidity__c = smth.data.get(0).rh;
            parsedCityWeather.Description__c = smth.data.get(0).weather.description;

        } else {
            System.debug(response.getStatus());
        }
        return parsedCityWeather;
    }
}