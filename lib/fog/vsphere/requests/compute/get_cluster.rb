module Fog
  module Compute
    class Vsphere
      class Real
        def get_cluster(name, datacenter_name)
          cluster = get_raw_cluster(name, datacenter_name)
          raise(Fog::Compute::Vsphere::NotFound) unless cluster
          cluster_attributes(cluster, datacenter_name)
        end

        protected

        def get_raw_cluster(name, datacenter_name_or_obj)
          dc = if datacenter_name_or_obj.is_a?(String)
                 find_raw_datacenter(datacenter_name_or_obj)
               else
                 datacenter_name_or_obj
               end
          dc.find_compute_resource(name)
        end
      end

      class Mock
        def get_cluster(name, datacenter_name)
          data[:clusters].find { |c| c[:name] == name && c[:datacenter] == datacenter_name } ||
            raise(Fog::Compute::Vsphere::NotFound)
        end
      end
    end
  end
end
