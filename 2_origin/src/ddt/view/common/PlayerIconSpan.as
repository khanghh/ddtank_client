package ddt.view.common
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import ddt.data.player.BasePlayer;
   import ddt.manager.PlayerManager;
   import ddt.manager.StateManager;
   import ddt.view.academyCommon.academyIcon.AcademyIcon;
   import flash.utils.getDefinitionByName;
   
   public class PlayerIconSpan extends VBox
   {
       
      
      private var _info:BasePlayer;
      
      private var _levelIcon:LevelIcon;
      
      private var _vipIcon:VipLevelIcon;
      
      private var _marriedIcon:MarriedIcon;
      
      private var _academyIcon:AcademyIcon;
      
      public function PlayerIconSpan(param1:BasePlayer)
      {
         _info = param1;
         super();
      }
      
      override protected function init() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = undefined;
         super.init();
         if(_info)
         {
            if(_levelIcon == null)
            {
               _levelIcon = new LevelIcon();
            }
            _levelIcon.setSize(0);
            _loc2_ = 1;
            if(StateManager.currentStateType == "fighting" || StateManager.currentStateType == "trainer1" || StateManager.currentStateType == "trainer2" || StateManager.currentStateType == "fightLabGameView")
            {
               _loc1_ = getDefinitionByName("gameCommon.GameControl");
               if(_loc1_)
               {
                  _loc2_ = _loc1_.Instance.Current.findLivingByPlayerID(_info.ID,_info.ZoneID) == null?-1:_loc1_.Instance.Current.findLivingByPlayerID(_info.ID,_info.ZoneID).team;
               }
            }
            _levelIcon.setInfo(_info.Grade,_info.ddtKingGrade,_info.Repute,_info.WinCount,_info.TotalCount,_info.FightPower,_info.Offer,true,false,_loc2_);
            addChild(_levelIcon);
            if(_info.ID == PlayerManager.Instance.Self.ID || _info.IsVIP)
            {
               if(_vipIcon == null)
               {
                  _vipIcon = new VipLevelIcon();
                  addChild(_vipIcon);
               }
               _vipIcon.setInfo(_info);
               if(!_info.IsVIP)
               {
                  _vipIcon.filters = ComponentFactory.Instance.creatFilters("grayFilter");
               }
               else
               {
                  _vipIcon.filters = null;
               }
            }
            else if(_vipIcon)
            {
               _vipIcon.dispose();
               _vipIcon = null;
            }
            if(_info.SpouseID > 0)
            {
               if(_marriedIcon == null)
               {
                  _marriedIcon = new MarriedIcon();
               }
               _marriedIcon.tipData = {
                  "nickName":_info.SpouseName,
                  "gender":_info.Sex
               };
               addChild(_marriedIcon);
            }
            else if(_marriedIcon)
            {
               _marriedIcon.dispose();
               _marriedIcon = null;
            }
         }
         else
         {
            if(_levelIcon)
            {
               _levelIcon.dispose();
               _levelIcon = null;
            }
            if(_vipIcon)
            {
               _vipIcon.dispose();
               _vipIcon = null;
            }
            if(_marriedIcon)
            {
               _marriedIcon.dispose();
               _marriedIcon = null;
            }
         }
         if(getShowAcademyIcon())
         {
            _academyIcon = new AcademyIcon();
            _academyIcon.tipData = _info;
            _academyIcon.visible = true;
            addChild(_academyIcon);
         }
         else if(_academyIcon)
         {
            _academyIcon.tipData = _info;
         }
         if(_marriedIcon)
         {
            if(_vipIcon)
            {
               _marriedIcon.y = 150;
            }
            else
            {
               _marriedIcon.y = 120;
            }
            if(_academyIcon)
            {
               _academyIcon.y = _marriedIcon.y + _marriedIcon.height + 6;
            }
         }
         else if(_vipIcon)
         {
            if(_academyIcon)
            {
               _academyIcon.y = _vipIcon.y + _vipIcon.height + 6;
            }
         }
         else if(_academyIcon)
         {
            _academyIcon.y = _levelIcon.y + _levelIcon.height + 3;
         }
      }
      
      private function getShowAcademyIcon() : Boolean
      {
         if(StateManager.currentStateType == "fighting" || StateManager.currentStateType == "fightLabGameView")
         {
            if(!_academyIcon && _info.apprenticeshipState != 0)
            {
               return true;
            }
            return false;
         }
         if(!_academyIcon && _info.ID == PlayerManager.Instance.Self.ID)
         {
            return true;
         }
         if(!_academyIcon && _info.ID != PlayerManager.Instance.Self.ID && _info.apprenticeshipState != 0)
         {
            return true;
         }
         return false;
      }
   }
}
