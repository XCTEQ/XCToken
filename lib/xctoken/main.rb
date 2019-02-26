require 'thor'
require 'fileutils'
require 'xctoken/version'
require "base64"
require "jwt"
require 'openssl'

module XCToken
	class Main < Thor
	  include Thor::Actions
  desc "generate", "Genarate AppStore Connect Token"
  def generate
		issuer_id = ENV["ISSUER_ID"]
		key_id = ENV["KEY_ID"]
		key_dir = ENV["KEY_DIR"]

		if File.file?("#{key_dir}/AuthKey_#{key_id}.p8")
			puts "Private Key Exist in the correct format with and matching identifier"
	    else
	       puts "Private key not found in the specified directory with key identifier assiciated"
	       puts "Please make sure KEY_DIR and KEY_ID environmetal varibales set correctly and private key exist in the KEY_DIR"
	       raise 'Private Key not setup correctly. Please make sure ENV[KEY_DIR] has private key'
	    end

	    private_key = OpenSSL::PKey.read(File.read("#{key_dir}/AuthKey_#{key_id}.p8"))

		$token = JWT.encode(
		   {
		    iss: issuer_id,
		    exp: Time.now.to_i + 20 * 60,
		    aud: "appstoreconnect-v1"
		   },
		   private_key,
		   "ES256",
		   header_fields = {
		     kid: 1234,
		   }
		 )
		puts $token
  end
 end
end