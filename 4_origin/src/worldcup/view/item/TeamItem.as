package worldcup.view.item
{
   import ddt.manager.LanguageMgr;
   import morn.core.components.CheckBox;
   import morn.core.components.Image;
   import morn.core.events.UIEvent;
   import worldcup.WorldcupControl;
   import worldcup.WorldcupManager;
   import worldcup.view.mornui.item.TeamItemUI;
   
   public class TeamItem extends TeamItemUI
   {
       
      
      private var teamNameList:Array;
      
      private var _team:int;
      
      public function TeamItem()
      {
         teamNameList = LanguageMgr.GetTranslation("ddt.worldcupGuess.allTeam").split("|");
         super();
      }
      
      public function get team() : int
      {
         return _team;
      }
      
      public function set team(value:int) : void
      {
         _team = value;
         updateView();
      }
      
      public function updateView() : void
      {
         teamTitle.skin = "asset.worldcup.group" + String(_team);
         var arr:Array = WorldcupManager.instance.model.countryList[_team - 1];
         for(var i:int = 0; i < arr.length; )
         {
            with(getChildByName("team" + String(i + 1)) as CheckBox)
            {
               
               imageLabel = "asset.worldcup.team" + String(arr[i]);
               disabled = WorldcupManager.instance.model.state != 2 || WorldcupManager.instance.model.supportCountry != 0;
               tipData = teamNameList[arr[i] - 1];
               if(disabled)
               {
                  selected = WorldcupManager.instance.model.supportCountry == arr[i];
                  filters = null;
               }
               else
               {
                  selected = WorldcupManager.instance.model.selectCountry == arr[i];
               }
               addEventListener(Event.SELECT,selectHandler);
            }
            with(getChildByName("tip" + String(i + 1)) as Image)
            {
               
               tipData = teamNameList[arr[i] - 1];
            }
            with(getChildByName("icon" + String(i + 1)) as Image)
            {
               
               if(WorldcupManager.instance.model.state > 2)
               {
                  visible = WorldcupManager.instance.model.promotionCountry.indexOf(arr[i]) == -1;
               }
               else
               {
                  visible = false;
               }
            }
            i = Number(i) + 1;
         }
      }
      
      private function selectHandler(e:UIEvent) : void
      {
         var arr:Array = WorldcupManager.instance.model.countryList[_team - 1];
         if(e.currentTarget.selected)
         {
            WorldcupManager.instance.model.selectCountry = arr[int(e.currentTarget.name.substr(4,1) - 1)];
         }
         WorldcupControl.instance.mainFrame.betView.listGroup.refresh();
      }
      
      override public function dispose() : void
      {
         var arr:Array = WorldcupManager.instance.model.countryList[_team - 1];
         for(var i:int = 0; i < arr.length; )
         {
            with(getChildByName("team" + String(i + 1)) as CheckBox)
            {
               
               removeEventListener(Event.SELECT,selectHandler);
            }
            i = Number(i) + 1;
         }
         super.dispose();
      }
   }
}
