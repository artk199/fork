package pl.fork;

import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.os.IBinder;
import android.util.Log;

public class LocationService extends Service implements LocationListener {

    private final String LOG_TAG = "GPSLocationService";
    private final Context context;

    private boolean networkEnabled;
    private boolean gpsEnabled;

    private LocationManager locationManager;

    private Location location;

    // The minimum distance to change Updates in meters
    private static final long MIN_DISTANCE_CHANGE_FOR_UPDATES = 10; // 10 meters

    // The minimum time between updates in milliseconds
    private static final long MIN_TIME_BW_UPDATES = 1000 * 60 * 1; // 1 minute


    public LocationService(Context context) {
        this.context = context;
    }

    @Override
    public IBinder onBind(Intent intent) {
        // TODO: Return the communication channel to the service.
        throw new UnsupportedOperationException("Not yet implemented");
    }

    public Location getLocation() {

        locationManager = (LocationManager) context.getSystemService(LOCATION_SERVICE);

        // getting GPS status
        gpsEnabled = locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER);

        // getting network status
        networkEnabled = locationManager.isProviderEnabled(LocationManager.NETWORK_PROVIDER);

        if (!gpsEnabled && !networkEnabled) {
            Log.e(LOG_TAG, "Brak włączonego modułu wyszukiwania lokalizacji.");
            return null;
        }

        Location networkLocation = getLocation(LocationManager.NETWORK_PROVIDER);
        Location gpsLocation = getLocation(LocationManager.NETWORK_PROVIDER);

        return getBestLocation(networkLocation,gpsLocation);
    }

    private Location getBestLocation(Location networkLocation, Location gpsLocation) {
        long GPSLocationTime = 0;
        long NetLocationTime = 0;

        if(gpsLocation != null) {
            GPSLocationTime = gpsLocation.getTime();
        }
        if(networkLocation != null) {
            NetLocationTime = networkLocation.getTime();
        }
        if(GPSLocationTime - NetLocationTime < 0) {
            return gpsLocation;
        }
        else {
            return networkLocation;
        }
    }

    private Location getLocation(String locationProvider) {
         try {
            locationManager.requestLocationUpdates(
                    locationProvider,
                    MIN_TIME_BW_UPDATES,
                    MIN_DISTANCE_CHANGE_FOR_UPDATES, this);

            Log.d(LOG_TAG, locationProvider + " Enabled");

            if (locationManager != null) {
                location = locationManager
                        .getLastKnownLocation(locationProvider);
            }
        } catch (SecurityException e) {
            Log.e(LOG_TAG, "PERMISSION_NOT_GRANTED " + locationProvider);
        } catch (Exception e){
             e.printStackTrace();
         }
        return location;
    }


    @Override
    public void onLocationChanged(Location location) {

    }

    @Override
    public void onStatusChanged(String provider, int status, Bundle extras) {

    }

    @Override
    public void onProviderEnabled(String provider) {

    }

    @Override
    public void onProviderDisabled(String provider) {

    }
}
