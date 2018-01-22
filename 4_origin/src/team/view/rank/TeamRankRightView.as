package team.view.rank
{
   import com.pickgliss.ui.LayerManager;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.ChatManager;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.ShowCharacter;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import team.TeamManager;
   import team.model.TeamLevelInfo;
   import team.model.TeamRankInfo;
   import team.view.mornui.Rank.TeamRankRightViewUI;
   
   public class TeamRankRightView extends TeamRankRightViewUI
   {
       
      
      private var _figure:Bitmap;
      
      private var _character:ShowCharacter;
      
      private var _info:TeamRankInfo;
      
      private var _enabled:Boolean;
      
      public function TeamRankRightView()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         btn_priChat.addEventListener("click",__onClickChat);
         btn_priChat.label = LanguageMgr.GetTranslation("ddt.team.allView.text2");
         btn_addFriend.addEventListener("click",__onClickAddFriend);
         btn_addFriend.label = LanguageMgr.GetTranslation("ddt.team.allView.text3");
      }
      
      private function show(param1:PlayerInfo) : void
      {
         if(_character)
         {
            _character.removeEventListener("complete",__characterComplete);
            _character.dispose();
            _character = null;
         }
         if(_figure && _figure.parent && _figure.bitmapData)
         {
            _figure.parent.removeChild(_figure);
            _figure.bitmapData.dispose();
            _figure = null;
         }
         _character = CharactoryFactory.createCharacter(param1) as ShowCharacter;
         _character.addEventListener("complete",__characterComplete);
         _character.showGun = false;
         _character.setShowLight(false,null);
         _character.stopAnimation();
         _character.show(true,1);
         var _loc2_:* = false;
         _character.mouseEnabled = _loc2_;
         _loc2_ = _loc2_;
         _character.mouseEnabled = _loc2_;
         _character.buttonMode = _loc2_;
      }
      
      protected function __characterComplete(param1:Event) : void
      {
         if(_figure && _figure.parent && _figure.bitmapData)
         {
            _figure.parent.removeChild(_figure);
            _figure.bitmapData.dispose();
            _figure = null;
         }
         if(!_character.info.getShowSuits())
         {
            _figure = new Bitmap(new BitmapData(200,150));
            _figure.bitmapData.copyPixels(_character.characterBitmapdata,new Rectangle(0,60,200,150),new Point(0,0));
            _figure.scaleX = 0.45;
            _figure.scaleY = 0.45;
            _figure.x = -7;
            _figure.y = 16;
         }
         else
         {
            _figure = new Bitmap(new BitmapData(200,200));
            _figure.bitmapData.copyPixels(_character.characterBitmapdata,new Rectangle(0,10,200,200),new Point(0,0));
            _figure.scaleX = 0.35;
            _figure.scaleY = 0.35;
            _figure.x = -1;
            _figure.y = 13;
         }
         addChild(_figure);
      }
      
      protected function __onClickAddFriend(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         IMManager.Instance.addFriend(_info.CreaterName);
      }
      
      protected function __onClickChat(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         ChatManager.Instance.privateChatTo(_info.CreaterName,_info.CreaterId);
         LayerManager.Instance.addToLayer(ChatManager.Instance.view,3);
      }
      
      private function getStrLen(param1:String) : String
      {
         var _loc2_:* = null;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeMultiByte(param1,"");
         if(_loc3_.length > 12)
         {
            _loc3_.position = 0;
            _loc2_ = _loc3_.readMultiByte(12,"");
            _loc2_ = _loc2_ + "...";
            return _loc2_;
         }
         return param1;
      }
      
      private function headerNameProcess(param1:String) : String
      {
         var _loc2_:int = 0;
         if(label_headerName.textField.textWidth > label_headerName.textField.width)
         {
            _loc2_ = label_headerName.textField.getCharIndexAtPoint(label_headerName.textField.width - 22,5);
            param1 = param1.substring(0,_loc2_) + "...";
         }
         return param1;
      }
      
      public function updateInfo(param1:TeamRankInfo) : void
      {
         var _loc4_:* = null;
         var _loc2_:Number = NaN;
         var _loc3_:* = null;
         var _loc6_:* = null;
         var _loc5_:int = 0;
         _info = param1;
         if(param1)
         {
            label_headerName.text = _info.CreaterName;
            label_headerName.text = headerNameProcess(label_headerName.text);
            label_teamLevel.text = "LV." + String(_info.TeamLevel);
            label_teamLabel.text = _info.TeamDesc;
            _loc4_ = TeamManager.instance.model.teamLevelInfoByLevel(_info.TeamLevel);
            label_teamNumber.text = String(_info.PlayerNum) + "/" + _loc4_.MaxPlayerNum;
            _loc2_ = _info.Total > 0?_info.Win / _info.Total * 100:0;
            label_teamWinPer.text = _loc2_.toFixed(2) + "%";
            label_teamScreenings.text = String(_info.Total);
            if(_info.SeasonRank == "" || !_info.SeasonRank)
            {
               label_teamHonor.text = LanguageMgr.GetTranslation("team.invite.nothonor");
            }
            else
            {
               _loc3_ = _info.SeasonRank.split("|");
               _loc6_ = [0,0];
               _loc5_ = 0;
               while(_loc5_ < _loc3_.length)
               {
                  if(_loc3_[_loc5_].length > 0)
                  {
                     _loc3_[_loc5_] = _loc3_[_loc5_].split(",");
                     if(_loc3_[_loc5_][1] >= _loc6_[1])
                     {
                        _loc6_[0] = _loc3_[_loc5_][0];
                        _loc6_[1] = _loc3_[_loc5_][1];
                     }
                  }
                  _loc5_++;
               }
               label_teamHonor.text = LanguageMgr.GetTranslation("team.rank.teamHonor",_loc6_[0],_loc6_[1]);
            }
         }
         else
         {
            label_headerName.text = "";
            label_teamLevel.text = "";
            label_teamLabel.text = "";
            label_teamNumber.text = "";
            label_teamWinPer.text = "";
            label_teamScreenings.text = "";
            label_teamHonor.text = "";
         }
         updaHead();
      }
      
      private function updaHead() : void
      {
         if(!_info)
         {
            deletehead();
            return;
         }
         var _loc1_:PlayerInfo = PlayerManager.Instance.findPlayer(_info.CreaterId);
         _loc1_.beginChanges();
         _loc1_.Style = _info.CreaterStyle;
         _loc1_.Skin = _info.CreaterSkin;
         _loc1_.Colors = _info.CreaterColors;
         _loc1_.Sex = _info.Sex;
         if(_info.IsVIP > 0)
         {
            _loc1_.IsVIP = true;
         }
         else
         {
            _loc1_.IsVIP = false;
         }
         _loc1_.commitChanges();
         show(_loc1_);
      }
      
      public function set enabled(param1:Boolean) : void
      {
         _enabled = param1;
         if(!_info)
         {
            var _loc2_:* = true;
            btn_priChat.disabled = _loc2_;
            btn_addFriend.disabled = _loc2_;
         }
         else
         {
            _loc2_ = !_enabled;
            btn_priChat.disabled = _loc2_;
            btn_addFriend.disabled = _loc2_;
         }
      }
      
      private function deletehead() : void
      {
         if(_character)
         {
            _character.removeEventListener("complete",__characterComplete);
            _character.dispose();
            _character = null;
         }
         if(_figure && _figure.parent && _figure.bitmapData)
         {
            _figure.parent.removeChild(_figure);
            _figure.bitmapData.dispose();
            _figure = null;
         }
      }
      
      override public function dispose() : void
      {
         deletehead();
         btn_priChat.removeEventListener("click",__onClickChat);
         btn_addFriend.removeEventListener("click",__onClickAddFriend);
         super.dispose();
      }
   }
}
