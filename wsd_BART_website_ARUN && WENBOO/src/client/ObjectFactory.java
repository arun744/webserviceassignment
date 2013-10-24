
package client;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlElementDecl;
import javax.xml.bind.annotation.XmlRegistry;
import javax.xml.namespace.QName;


/**
 * This object contains factory methods for each 
 * Java content interface and Java element interface 
 * generated in the client package. 
 * <p>An ObjectFactory allows you to programatically 
 * construct new instances of the Java representation 
 * for XML content. The Java representation of XML 
 * content can consist of schema derived interfaces 
 * and classes representing the binding of schema 
 * type definitions, element declarations and model 
 * groups.  Factory methods for each of these are 
 * provided in this class.
 * 
 */
@XmlRegistry
public class ObjectFactory {

    private final static QName _GetStations_QNAME = new QName("tns:fare", "getStations");
    private final static QName _SayHello_QNAME = new QName("tns:fare", "sayHello");
    private final static QName _SayHelloResponse_QNAME = new QName("tns:fare", "sayHelloResponse");
    private final static QName _GetStationsResponse_QNAME = new QName("tns:fare", "getStationsResponse");
    private final static QName _GetFare_QNAME = new QName("tns:fare", "getFare");
    private final static QName _GetFareResponse_QNAME = new QName("tns:fare", "getFareResponse");

    /**
     * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: client
     * 
     */
    public ObjectFactory() {
    }

    /**
     * Create an instance of {@link GetStationsResponseType }
     * 
     */
    public GetStationsResponseType createGetStationsResponseType() {
        return new GetStationsResponseType();
    }

    /**
     * Create an instance of {@link GetStationsRequestType }
     * 
     */
    public GetStationsRequestType createGetStationsRequestType() {
        return new GetStationsRequestType();
    }

    /**
     * Create an instance of {@link GetFareRequestType }
     * 
     */
    public GetFareRequestType createGetFareRequestType() {
        return new GetFareRequestType();
    }

    /**
     * Create an instance of {@link SayHelloResponseType }
     * 
     */
    public SayHelloResponseType createSayHelloResponseType() {
        return new SayHelloResponseType();
    }

    /**
     * Create an instance of {@link SayHelloRequestType }
     * 
     */
    public SayHelloRequestType createSayHelloRequestType() {
        return new SayHelloRequestType();
    }

    /**
     * Create an instance of {@link GetFareResponseType }
     * 
     */
    public GetFareResponseType createGetFareResponseType() {
        return new GetFareResponseType();
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link GetStationsRequestType }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "tns:fare", name = "getStations")
    public JAXBElement<GetStationsRequestType> createGetStations(GetStationsRequestType value) {
        return new JAXBElement<GetStationsRequestType>(_GetStations_QNAME, GetStationsRequestType.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link SayHelloRequestType }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "tns:fare", name = "sayHello")
    public JAXBElement<SayHelloRequestType> createSayHello(SayHelloRequestType value) {
        return new JAXBElement<SayHelloRequestType>(_SayHello_QNAME, SayHelloRequestType.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link SayHelloResponseType }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "tns:fare", name = "sayHelloResponse")
    public JAXBElement<SayHelloResponseType> createSayHelloResponse(SayHelloResponseType value) {
        return new JAXBElement<SayHelloResponseType>(_SayHelloResponse_QNAME, SayHelloResponseType.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link GetStationsResponseType }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "tns:fare", name = "getStationsResponse")
    public JAXBElement<GetStationsResponseType> createGetStationsResponse(GetStationsResponseType value) {
        return new JAXBElement<GetStationsResponseType>(_GetStationsResponse_QNAME, GetStationsResponseType.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link GetFareRequestType }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "tns:fare", name = "getFare")
    public JAXBElement<GetFareRequestType> createGetFare(GetFareRequestType value) {
        return new JAXBElement<GetFareRequestType>(_GetFare_QNAME, GetFareRequestType.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link GetFareResponseType }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "tns:fare", name = "getFareResponse")
    public JAXBElement<GetFareResponseType> createGetFareResponse(GetFareResponseType value) {
        return new JAXBElement<GetFareResponseType>(_GetFareResponse_QNAME, GetFareResponseType.class, null, value);
    }

}
