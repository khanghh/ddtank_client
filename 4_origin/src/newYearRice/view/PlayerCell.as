package newYearRice.view
{
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
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
   import newYearRice.NewYearRiceManager;
   
   public class PlayerCell extends Sprite
   {
      
      public static const LEFT:String = "left";
      
      public static const RIGHT:String = "right";
       
      
      private var _directrion:String;
      
      private var _info:PlayerInfo;
      
      private var _character:ShowCharacter;
      
      private var _figure:Bitmap;
      
      private var components:Component;
      
      private var _dic:Dictionary;
      
      private var _playerID:int;
      
      private var _style:String;
      
      private var _nikeName:String;
      
      private var _sex:Boolean;
      
      public function PlayerCell()
      {
         super();
      }
      
      public function setNickName($playerID:int, $direction:String = "left", $style:String = "", $nikeName:String = "", $sex:Boolean = false) : void
      {
         NewYearRiceManager.instance.model.playerNum = NewYearRiceManager.instance.model.playerNum + 1;
         _playerID = $playerID;
         _directrion = $direction;
         _style = $style;
         _nikeName = $nikeName;
         _sex = $sex;
         setInfo();
      }
      
      private function setInfo() : void
      {
         _info = new PlayerInfo();
         if(_playerID == PlayerManager.Instance.Self.ID)
         {
            _info = PlayerManager.Instance.Self;
         }
         else
         {
            _info = PlayerManager.Instance.findPlayer(_playerID);
            _info.Style = _style;
            _info.NickName = _nikeName;
            _info.Sex = _sex;
         }
         if(_info.ID && _info.Style)
         {
            updateCharacter();
         }
         else
         {
            SocketManager.Instance.out.sendItemEquip(_playerID,true);
            _info.addEventListener("propertychange",__playerInfoChange);
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
         _figure.width = 55;
         _figure.height = 48;
         if(_info != null)
         {
            components = NewYearRiceManager.instance.returnComponent(_figure,LanguageMgr.GetTranslation("asset.playerCell.tip",_info.NickName));
            components.scaleX = _directrion == "left"?1:-1;
            addChild(components);
         }
      }
      
      public function dispose() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get playerID() : int
      {
         return _playerID;
      }
      
      public function get info() : PlayerInfo
      {
         return _info;
      }
      
      public function removePlayerCell() : void
      {
         if(_info)
         {
            ObjectUtils.disposeObject(_info);
            _info = null;
         }
         if(components)
         {
            ObjectUtils.disposeObject(components);
            components = null;
         }
         _directrion = "";
         _style = "";
         _nikeName = "";
      }
      
      public function set info(value:PlayerInfo) : void
      {
         _info = value;
      }
      
      public function get nikeName() : String
      {
         return _nikeName;
      }
      
      public function set nikeName(value:String) : void
      {
         _nikeName = value;
      }
   }
}
