package org.reporterslab.archiver.models
{
	import mx.collections.ArrayCollection;
	
	import org.reporterslab.archiver.events.ArchiverModelEvent;
	import org.reporterslab.archiver.models.vo.Status;
	import org.robotlegs.mvcs.Actor;
	
	public class ArchiverModel extends Actor
	{
		
		private var _statuses:ArrayCollection = new ArrayCollection();
		private var _selectedStatus:Status;
		private var _searchedStatuses:ArrayCollection;
		
		/**
		 * Holds the current list of statuses for display. This is probably going to be the most recent X number of statuses,
		 *  which increases as new come in.
		 **/
		public function get statuses():ArrayCollection
		{
			return _statuses;
		}
		
		public function set statuses(value:ArrayCollection):void
		{
			this._statuses = statuses;
			dispatch(new ArchiverModelEvent(ArchiverModelEvent.STATUSES_CHANGED, this.statuses));
		}
		
		/**
		 * The selected status. User clicks a status at any point, view should notify that something has been selected and
		 * we should handle that change here.
		 **/
		public function get selectedStatus():Status
		{
			return _selectedStatus;
		}
		
		public function set selectedStatus(value:Status):void
		{
			this._selectedStatus = value;
			dispatch(new ArchiverModelEvent(ArchiverModelEvent.STATUS_SELECTED, null, this.selectedStatus));
		}
		
		/**
		 * The latest search results. I feel like searching for data is different enough from just loading new data that
		 * we may want to keep the lists of statuses separate. This may be changed.
		 **/
		public function get searchedStatuses():ArrayCollection
		{
			return this._searchedStatuses;
		}
		
		public function set searchedStatuses(value:ArrayCollection):void
		{
			this._searchedStatuses = value;
			dispatch(new ArchiverModelEvent(ArchiverModelEvent.STATUSES_SEARCHED, this.searchedStatuses));
		}
		
		public function ArchiverModel()
		{
			super();
			trace("Archiver model created");
		}
		
		
		/**
		 * Merges a vector of statuses with the existing collection.
		 * @param statuses      Required. A Vector of Status objects to merge with the statuses ArrayCollection.
		 **/
		public function addStatuses(statuses:Vector.<Status>):void
		{
			for each(var s:Status in statuses)
			{
				this.statuses.addItem(s);
			}
			
			dispatch(new ArchiverModelEvent(ArchiverModelEvent.STATUS_ADDED, this.statuses));
		}
		
	}
}