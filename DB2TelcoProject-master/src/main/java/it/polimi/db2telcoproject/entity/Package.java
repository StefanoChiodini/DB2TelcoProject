package it.polimi.db2telcoproject.entity;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Entity
@Table(name = "packages", schema = "dbtest")
@NamedQuery(name = "Package.availablePackages", query = "SELECT p FROM Package p")
public class Package implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int pkgId;
    @Column()
    private String name;

    @OneToOne
    @JoinColumn(name = "service1Id", referencedColumnName = "servId")
    private Service service1Id;
    @OneToOne
    @JoinColumn(name = "service2Id", referencedColumnName = "servId")
    private Service service2Id;
    @OneToOne
    @JoinColumn(name = "service3Id", referencedColumnName = "servId")
    private Service service3Id;
    @OneToOne
    @JoinColumn(name = "service4Id", referencedColumnName = "servId")
    private Service service4Id;
    /* Useless, added for completeness
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "pkgId", cascade = CascadeType.ALL)
    private List<Order> connectedOrders;

     */
    @ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @JoinTable(name = "connectedproducts", joinColumns ={@JoinColumn(name = "packageid")}, inverseJoinColumns = {@JoinColumn(name = "productid")})
    private List<OptionalProduct> products;
    @OneToMany(mappedBy = "aPackage", fetch = FetchType.EAGER)
    private ArrayList<PackagesPrices> prices = new ArrayList<>();



    public Package() {
    }

    public Package(String name, List<Service> services, List<OptionalProduct> products) {
        this.name = name;
        this.service1Id = services.get(0);
        try {
            if(services.get(1)!=null)
                this.service2Id=services.get(1);
        } catch (IndexOutOfBoundsException ignored) {

        }
        try {
            if(services.get(2)!=null)
                this.service3Id=services.get(2);
        } catch (IndexOutOfBoundsException ignored) {

        }
        try {
            if(services.get(3)!=null)
                this.service4Id=services.get(3);
        } catch (IndexOutOfBoundsException ignored) {

        }
        this.products = products;
    }

    public void addPrices(float price, ValidityPeriod period) {
        PackagesPrices newPrice = new PackagesPrices(price, this, period);
        prices.add(newPrice);
    }

    public int getPkgId() {
        return pkgId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }


    public Service getService1Id() {
        return service1Id;
    }

    public Service getService2Id() {
        return service2Id;
    }

    public Service getService3Id() {
        return service3Id;
    }

    public Service getService4Id() {
        return service4Id;
    }

    public List<OptionalProduct> getProducts() {
        return products;
    }

    public ArrayList<PackagesPrices> getPrices() {
        return prices;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Package aPackage = (Package) o;
        return pkgId == aPackage.pkgId && name.equals(aPackage.name) && service1Id.equals(aPackage.service1Id) && Objects.equals(service2Id, aPackage.service2Id) && Objects.equals(service3Id, aPackage.service3Id) && Objects.equals(service4Id, aPackage.service4Id) && Objects.equals(products, aPackage.products);
    }

    @Override
    public int hashCode() {
        return Objects.hash(pkgId, name, service1Id, service2Id, service3Id, service4Id, products);
    }
}
