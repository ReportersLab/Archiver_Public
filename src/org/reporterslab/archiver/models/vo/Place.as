package org.reporterslab.archiver.models.vo
{
	import com.dborisenko.api.twitter.data.TwitterPlace;

	public class Place
	{
		public var id:int = -1;
		//should be generic enough for any place.
		public var name:String;
		public var countryCode:String;
		public var country:String;
		public var attributes:Object;
		public var url:String;
		public var boundingBox:Object; //how to save to db?
		public var fullName:String;
		public var type:String;
		
		public var twitterId:String;
		
		
		public function Place()
		{
			
		}
		
		public function parseTwitterPlace(place:TwitterPlace):Place
		{
			name = place.name;
			countryCode = place.countryCode;
			country = place.country;
			attributes = place.attributes;
			url = place.url;
			twitterId = place.id;
			boundingBox = place.boundingBox; // contains coords and types. Not sure what's available here. Docs are laaaame.
			fullName = place.fullName;
			type = place.type;
			
			return this;
		}
		
		
		public function toParams():Object
		{
			var params:Object = {};
			params['id'] = this.id == -1 ? null : this.id;
			params['name'] = this.name;
			params['countryCode'] = this.countryCode;
			params['country'] = this.country;
			params['attributes'] = JSON.stringify(this.attributes);
			params['url'] = this.url;
			params['boundingBox'] = JSON.stringify(this.boundingBox); 
			params['fullName'] = this.fullName;
			params['type'] = this.type;
			params['twitterId'] = this.twitterId;
			return params;	
		}
		
	}
}