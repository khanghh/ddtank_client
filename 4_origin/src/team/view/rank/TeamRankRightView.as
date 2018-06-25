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
      
      private function show(info:PlayerInfo) : void
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
         _character = CharactoryFactory.createCharacter(info) as ShowCharacter;
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
      
      protected function __characterComplete(event:Event) : void
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
      
      protected function __onClickAddFriend(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         IMManager.Instance.addFriend(_info.CreaterName);
      }
      
      protected function __onClickChat(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         ChatManager.Instance.privateChatTo(_info.CreaterName,_info.CreaterId);
         LayerManager.Instance.addToLayer(ChatManager.Instance.view,3);
      }
      
      private function getStrLen(_str:String) : String
      {
         var str:* = null;
         var _ba:ByteArray = new ByteArray();
         _ba.writeMultiByte(_str,"");
         if(_ba.length > 12)
         {
            _ba.position = 0;
            str = _ba.readMultiByte(12,"");
            str = str + "...";
            return str;
         }
         return _str;
      }
      
      private function headerNameProcess(_str:String) : String
      {
         var tempIndex:int = 0;
         if(label_headerName.textField.textWidth > label_headerName.textField.width)
         {
            tempIndex = label_headerName.textField.getCharIndexAtPoint(label_headerName.textField.width - 22,5);
            _str = _str.substring(0,tempIndex) + "...";
         }
         return _str;
      }
      
      public function updateInfo(info:TeamRankInfo) : void
      {
         var teamLevelInfo:* = null;
         var rate:Number = NaN;
         var arr:* = null;
         var maxHonor:* = null;
         var i:int = 0;
         _info = info;
         if(info)
         {
            label_headerName.text = _info.CreaterName;
            label_headerName.text = headerNameProcess(label_headerName.text);
            label_teamLevel.text = "LV." + String(_info.TeamLevel);
            label_teamLabel.text = _info.TeamDesc;
            teamLevelInfo = TeamManager.instance.model.teamLevelInfoByLevel(_info.TeamLevel);
            label_teamNumber.text = String(_info.PlayerNum) + "/" + teamLevelInfo.MaxPlayerNum;
            rate = _info.Total > 0?_info.Win / _info.Total * 100:0;
            label_teamWinPer.text = rate.toFixed(2) + "%";
            label_teamScreenings.text = String(_info.Total);
            if(_info.SeasonRank == "" || !_info.SeasonRank)
            {
               label_teamHonor.text = LanguageMgr.GetTranslation("team.invite.nothonor");
            }
            else
            {
               arr = _info.SeasonRank.split("|");
               maxHonor = [0,0];
               for(i = 0; i < arr.length; )
               {
                  if(arr[i].length > 0)
                  {
                     arr[i] = arr[i].split(",");
                     if(arr[i][1] >= maxHonor[1])
                     {
                        maxHonor[0] = arr[i][0];
                        maxHonor[1] = arr[i][1];
                     }
                  }
                  i++;
               }
               label_teamHonor.text = LanguageMgr.GetTranslation("team.rank.teamHonor",maxHonor[0],maxHonor[1]);
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
         var playerInfo:PlayerInfo = PlayerManager.Instance.findPlayer(_info.CreaterId);
         playerInfo.beginChanges();
         playerInfo.Style = _info.CreaterStyle;
         playerInfo.Skin = _info.CreaterSkin;
         playerInfo.Colors = _info.CreaterColors;
         playerInfo.Sex = _info.Sex;
         if(_info.IsVIP > 0)
         {
            playerInfo.IsVIP = true;
         }
         else
         {
            playerInfo.IsVIP = false;
         }
         playerInfo.commitChanges();
         show(playerInfo);
      }
      
      public function set enabled(value:Boolean) : void
      {
         _enabled = value;
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
