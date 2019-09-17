public with sharing class WeatherLocator {

    static final String APIKEY = '1ed86a7e0c837a75e8969303abce51fa';

    @AuraEnabled
    public static CityWeather__c getWeather(String city) {

        String weatherAPI = 'http://api.openweathermap.org/data/2.5/weather?q=' + city + '&APPID=' + APIKEY + '&units=metric';

        System.debug('str: ' + weatherAPI);

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(weatherAPI);
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        CityWeather__c parsedCityWeather = new CityWeather__c();

        if (response.getStatusCode() == 200) {

            System.JSONParser parser = JSON.createParser(response.getBody());
            JSON2ApexWeather smth = (JSON2ApexWeather) System.JSON.deserialize(response.getBody(), JSON2ApexWeather.class);
            parsedCityWeather.Name = smth.name;
            parsedCityWeather.Temp__c = smth.main.temp;
            parsedCityWeather.Country__c = smth.sys.country;
            parsedCityWeather.Pressure__c = smth.main.pressure;
            parsedCityWeather.Humidity__c = smth.main.humidity;
//            parsedCityWeather.Description__c = smth.weather.main;

        } else {
            System.debug(response.getStatus());
        }
        return parsedCityWeather;
    }
}