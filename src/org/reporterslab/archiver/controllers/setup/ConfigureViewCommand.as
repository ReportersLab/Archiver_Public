package org.reporterslab.archiver.controllers.setup
{
	import org.reporterslab.archiver.events.ArchiverConfigurationEvent;
	import org.reporterslab.archiver.views.components.Details;
	import org.reporterslab.archiver.views.components.SearchPanel;
	import org.reporterslab.archiver.views.components.TwitterLogin;
	import org.reporterslab.archiver.views.components.details.EntityDetails;
	import org.reporterslab.archiver.views.components.details.PlaceDetails;
	import org.reporterslab.archiver.views.components.details.StatusDetails;
	import org.reporterslab.archiver.views.components.details.UserDetails;
	import org.reporterslab.archiver.views.components.lists.EntityList;
	import org.reporterslab.archiver.views.components.lists.PlaceList;
	import org.reporterslab.archiver.views.components.lists.StatusList;
	import org.reporterslab.archiver.views.components.lists.UserList;
	import org.reporterslab.archiver.views.mediators.ApplicationMediator;
	import org.reporterslab.archiver.views.mediators.DetailsMediator;
	import org.reporterslab.archiver.views.mediators.SearchPanelMediator;
	import org.reporterslab.archiver.views.mediators.TwitterLoginMediator;
	import org.reporterslab.archiver.views.mediators.details.EntityDetailsMediator;
	import org.reporterslab.archiver.views.mediators.details.PlaceDetailsMediator;
	import org.reporterslab.archiver.views.mediators.details.StatusDetailsMediator;
	import org.reporterslab.archiver.views.mediators.details.UserDetailsMediator;
	import org.reporterslab.archiver.views.mediators.lists.EntityListMediator;
	import org.reporterslab.archiver.views.mediators.lists.PlaceListMediator;
	import org.reporterslab.archiver.views.mediators.lists.StatusListMediator;
	import org.reporterslab.archiver.views.mediators.lists.UserListMediator;
	import org.reporterslab.archiver.views.renderers.SearchTermRenderer;
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
			mediatorMap.mapView(EntityDetails, EntityDetailsMediator);
			
		}
		
	}
}