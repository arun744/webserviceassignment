package dca.tranlist;

import java.beans.*;
import java.io.Serializable;
import java.io.FileOutputStream;
import java.io.ObjectOutputStream;
import java.io.FileInputStream;
import java.io.ObjectInputStream;
public class Trainlist implements Serializable {
	
	private String route_id;
	private String trip_id;
	private String stationid;
public Trainlist(){
	
}

public void setroute_id( String value )
{
    route_id = value;
}

public void settrip_id( String value )
{
    trip_id = value;
}

public void setStationId( String value )
{
    stationid = value;

}

public String getroute_id(){
	return route_id;
}

public String getStationId(){
	return stationid;
}

public String gettrip_id(){
	return  trip_id;
}

}




