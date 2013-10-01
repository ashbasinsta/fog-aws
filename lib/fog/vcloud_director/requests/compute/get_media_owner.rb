module Fog
  module Compute
    class VcloudDirector
      class Real
        # Retrieve the owner of a media object.
        #
        # @param [String] media_id Object identifier of the media object.
        # @return [Excon::Response]
        #   * body<~Hash>:
        # @see http://pubs.vmware.com/vcd-51/topic/com.vmware.vcloud.api.reference.doc_51/doc/operations/GET-MediaOwner.html
        #   vCloud API Documentation
        # @since vCloud API version 1.5
        def get_media_owner(media_id)
          request(
            :expects    => 200,
            :idempotent => true,
            :method     => 'GET',
            :parser     => Fog::ToHashDocument.new,
            :path       => "media/#{media_id}/owner"
          )
        end
      end

      class Mock
        def get_media_owner(media_id)
          response = Excon::Response.new

          unless valid_uuid?(media_id)
            response.status = 400
            raise Excon::Errors.status_error({:expects => 200}, response)
          end
          unless data[:medias].has_key?(media_id)
            response.status = 403
            raise Excon::Errors.status_error({:expects => 200}, response)
          end

          Fog::Mock.not_implemented
        end
      end
    end
  end
end
