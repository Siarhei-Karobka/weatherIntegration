public with sharing class WeatherLocator {

//    static final String APIKEY = '1ed86a7e0c837a75e8969303abce51fa'; //openWeatherMap
    static final String APIKEY = '6d8b17470e90473aa7510820e1c54f14'; //weatherbit

    public static HttpResponse callout(String weatherURI) {

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(weatherURI);
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        return response;
    }

    @AuraEnabled
    public static String getWeather(String city, Integer days) {
        String weatherAPI = 'https://api.weatherbit.io/v2.0/forecast/daily?city=' + city + '&key=' + APIKEY + '&days=' + days;
        weatherAPI = weatherAPI.replaceAll( '\\s+', '');
        System.debug(weatherAPI);
        String result;

        HttpResponse response = callout(weatherAPI);
        if (response.getStatusCode() == 200) {
            result = response.getBody();
        }


//        JSON2ApexWeather smth = (JSON2ApexWeather) System.JSON.deserialize(response.getBody(), JSON2ApexWeather.class);
//        parsedCityWeather.Name = smth.name;
//        parsedCityWeather.Temp__c = smth.main.temp;
//        parsedCityWeather.Country__c = smth.sys.country;
//        parsedCityWeather.Pressure__c = smth.main.pressure;
//        parsedCityWeather.Humidity__c = smth.main.humidity;

        return result;
    }
}