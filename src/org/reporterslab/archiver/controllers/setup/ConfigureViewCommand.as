package org.reporterslab.archiver.controllers.setup
{
	import org.reporterslab.archiver.events.ArchiverConfigurationEvent;
	import org.reporterslab.archiver.views.components.Details;
	import org.reporterslab.archiver.views.components.EntityList;
	import org.reporterslab.archiver.views.components.PlaceList;
	import org.reporterslab.archiver.views.components.SearchPanel;
	import org.reporterslab.archiver.views.components.StatusList;
	import org.reporterslab.archiver.views.components.TwitterLogin;
	import org.reporterslab.archiver.views.components.UserList;
	import org.reporterslab.archiver.views.components.details.PlaceDetails;
	import org.reporterslab.archiver.views.components.details.StatusDetails;
	import org.reporterslab.archiver.views.components.details.UserDetails;
	import org.reporterslab.archiver.views.mediators.ApplicationMediator;
	import org.reporterslab.archiver.views.mediators.DetailsMediator;
	import org.reporterslab.archiver.views.mediators.EntityListMediator;
	import org.reporterslab.archiver.views.mediators.PlaceListMediator;
	import org.reporterslab.archiver.views.mediators.SearchPanelMediator;
	import org.reporterslab.archiver.views.mediators.StatusListMediator;
	import org.reporterslab.archiver.views.mediators.TwitterLoginMediator;
	import org.reporterslab.archiver.views.mediators.UserListMediator;
	import org.reporterslab.archiver.views.mediators.details.PlaceDetailsMediator;
	import org.reporterslab.archiver.views.mediators.details.StatusDetailsMediator;
	import org.reporterslab.archiver.views.mediators.details.UserDetailsMediator;
	import org.robotlegs.mvcs.Command;
	
	public class ConfigureViewCommand extends Command
	{
		
		[Inject]
		public var event:ArchiverConfigurationEvent;
		
		override public function execute():void
		{
			trace("Configuring Views");
			//configure the views. Basically linking Mediators to Views.
			mediatorMap.mapView(Archiver, ApplicationMediator);
			mediatorMap.mapView(SearchPanel, SearchPanelMediator);
			mediatorMap.mapView(TwitterLogin, TwitterLoginMediator);
			mediatorMap.mapView(Details, DetailsMediator);
			
			//lists
			mediatorMap.mapView(StatusList, StatusListMediator);
			mediatorMap.mapView(UserList, UserListMediator);
			mediatorMap.mapView(PlaceList, PlaceListMediator);
			mediatorMap.mapView(EntityList, EntityListMediator);
			//details
			mediatorMap.mapView(StatusDetails, StatusDetailsMediator);
			mediatorMap.mapView(UserDetails, UserDetailsMediator);
			mediatorMap.mapView(PlaceDetails, PlaceDetailsMediator);
			
		}
		
	}
}