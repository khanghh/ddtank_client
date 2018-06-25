package kingDivision.view
{
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.ShowCharacter;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import kingDivision.KingDivisionManager;
   import kingDivision.data.KingDivisionConsortionItemInfo;
   
   public class KingCell extends Sprite implements Disposeable
   {
      
      public static const LEFT:String = "left";
      
      public static const RIGHT:String = "right";
       
      
      public var _playerInfo:KingDivisionConsortionItemInfo;
      
      private var _info:PlayerInfo;
      
      private var _character:ShowCharacter;
      
      private var _figure:Bitmap;
      
      private var _directrion:String;
      
      private var _consortionName:String;
      
      private var _index:int;
      
      private var components:Component;
      
      private var _dic:Dictionary;
      
      public function KingCell()
      {
         super();
         _dic = KingDivisionManager.Instance.dataDic;
      }
      
      public function setNickName(playerInfo:KingDivisionConsortionItemInfo, direction:String = "left") : void
      {
         if(_playerInfo == null)
         {
            _playerInfo = playerInfo;
            _directrion = direction;
            setInfo();
            return;
         }
         if(KingDivisionManager.Instance.zoneIndex != 0)
         {
            tipUpdate();
         }
      }
      
      private function setInfo() : void
      {
         _info = new PlayerInfo();
         if(KingDivisionManager.Instance.states == 2 && !KingDivisionManager.Instance.isThisZoneWin)
         {
            _info.Style = _playerInfo.consortionStyle;
            _info.Sex = _playerInfo.consortionSex;
            if(_info.Style)
            {
               updateCharacter();
            }
         }
         else
         {
            if(_playerInfo.name == PlayerManager.Instance.Self.NickName)
            {
               _info = PlayerManager.Instance.Self;
            }
            else
            {
               _info = PlayerManager.Instance.findPlayerByNickName(_info,_playerInfo.name);
            }
            if(KingDivisionManager.Instance.isThisZoneWin)
            {
               _info.Style = _playerInfo.conStyle;
               _info.Sex = _playerInfo.conSex;
               if(_info.Style)
               {
                  updateCharacter();
               }
            }
            else if(_info.ID && _info.Style)
            {
               updateCharacter();
            }
            else
            {
               SocketManager.Instance.out.sendItemEquip(_playerInfo.name,true);
               _info.addEventListener("propertychange",__playerInfoChange);
            }
         }
      }
      
      private function __playerInfoChange(event:PlayerPropertyEvent) : void
      {
         _info.removeEventListener("propertychange",__playerInfoChange);
         updateCharacter();
      }
      
      private function updateCharacter() : void
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
         _character = CharactoryFactory.createCharacter(_info) as ShowCharacter;
         _character.addEventListener("complete",__characterComplete);
         _character.showGun = false;
         _character.setShowLight(false,null);
         _character.stopAnimation();
         _character.show(true,1);
         var _loc1_:* = false;
         _character.mouseEnabled = _loc1_;
         _loc1_ = _loc1_;
         _character.mouseEnabled = _loc1_;
         _character.buttonMode = _loc1_;
      }
      
      private function __characterComplete(evt:Event) : void
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
         }
         else
         {
            _figure = new Bitmap(new BitmapData(200,200));
            _figure.bitmapData.copyPixels(_character.characterBitmapdata,new Rectangle(0,10,200,200),new Point(0,0));
         }
         _figure.width = 42;
         _figure.height = 36;
         if(KingDivisionManager.Instance.zoneIndex == 0)
         {
            components = KingDivisionManager.Instance.returnComponent(_figure,LanguageMgr.GetTranslation("asset.kingCell.tip",_playerInfo.conName,_playerInfo.score));
         }
         else if(_dic == null)
         {
            components = KingDivisionManager.Instance.returnComponent(_figure,LanguageMgr.GetTranslation("asset.kingCell.tip",_playerInfo.consortionNameArea,_playerInfo.consortionScoreArea));
         }
         else
         {
            components = KingDivisionManager.Instance.returnComponent(_figure,LanguageMgr.GetTranslation("asset.kingCell.tipArea",_playerInfo.consortionNameArea,_playerInfo.consortionScoreArea,_dic[_playerInfo.areaID]));
         }
         components.scaleX = _directrion == "left"?1:-1;
         addChild(components);
      }
      
      private function tipUpdate() : void
      {
         var figure:Bitmap = new Bitmap(new BitmapData(200,200));
         figure.width = 42;
         figure.height = 36;
         figure.visible = false;
         if(_dic == null)
         {
            components = KingDivisionManager.Instance.returnComponent(_figure,LanguageMgr.GetTranslation("asset.kingCell.tip",_playerInfo.consortionNameArea,_playerInfo.consortionScoreArea));
         }
         else
         {
            components = KingDivisionManager.Instance.returnComponent(_figure,LanguageMgr.GetTranslation("asset.kingCell.tipArea",_playerInfo.consortionNameArea,_playerInfo.consortionScoreArea,_dic[_playerInfo.areaID]));
         }
         components.scaleX = _directrion == "left"?1:-1;
         addChild(components);
      }
      
      public function get info() : PlayerInfo
      {
         return _info;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function set index(value:int) : void
      {
         _index = value;
      }
      
      public function dispose() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
