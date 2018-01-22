package ddt.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.utils.Helpers;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.ShowCharacter;
   import ddt.view.sceneCharacter.GirlHeadPicLoader;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class PlayerPortraitView extends Sprite implements Disposeable
   {
      
      public static const LEFT:String = "left";
      
      public static const RIGHT:String = "right";
       
      
      private var _needLoadGirlHead:Boolean;
      
      private var _mask:Shape;
      
      private var _character:ShowCharacter;
      
      private var _loaderGirlPhoto:GirlHeadPicLoader;
      
      private var _figure:Bitmap;
      
      private var _iconBg:ScaleFrameImage;
      
      private var _directrion:String;
      
      private var _info:PlayerInfo;
      
      public function PlayerPortraitView(param1:String = "left", param2:Boolean = false, param3:Boolean = true)
      {
         super();
         _directrion = param1;
         _needLoadGirlHead = param2;
         if(param3)
         {
            _iconBg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtgift.playerIcon");
            _iconBg.setFrame(1);
            addChild(_iconBg);
         }
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      public function onHeadSelectChange(param1:Boolean) : void
      {
         _needLoadGirlHead = param1;
         if(_info && this.parent)
         {
            showFigure(_info);
         }
      }
      
      public function set info(param1:PlayerInfo) : void
      {
         _info = param1;
         showFigure(param1);
      }
      
      public function get info() : PlayerInfo
      {
         return _info;
      }
      
      public function set iconFrame(param1:int) : void
      {
         if(_iconBg)
         {
            _iconBg.setFrame(param1);
         }
      }
      
      public function set isShowFrame(param1:Boolean) : void
      {
         if(param1)
         {
            addChildAt(_iconBg,0);
         }
         else if(contains(_iconBg))
         {
            removeChild(_iconBg);
         }
      }
      
      private function showFigure(param1:PlayerInfo) : void
      {
         if(_character)
         {
            _character.removeEventListener("complete",__characterComplete);
            _character.dispose();
            _character = null;
         }
         if(_loaderGirlPhoto)
         {
            _loaderGirlPhoto = null;
         }
         if(_figure && _figure.parent && _figure.bitmapData)
         {
            _figure.parent.removeChild(_figure);
            _figure.bitmapData.dispose();
            _figure = null;
         }
         if(_needLoadGirlHead && _info.ImagePath != "")
         {
            _loaderGirlPhoto = new GirlHeadPicLoader();
            _loaderGirlPhoto.load("http://ddthead.7road.com" + _info.ImagePath,onGirlLoaderComplete);
         }
         else
         {
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
      }
      
      private function onGirlLoaderComplete(param1:DisplayObject) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(_figure && _figure.parent && _figure.bitmapData)
         {
            _figure.parent.removeChild(_figure);
            _figure.bitmapData.dispose();
            _figure = null;
         }
         if(_mask == null)
         {
            _mask = new Shape();
            _mask.graphics.beginFill(16777215);
            _mask.graphics.drawRoundRect(0,0,70,68,6,6);
            _mask.graphics.endFill();
            _mask.x = 3;
            _mask.y = 7;
         }
         _figure = new Bitmap((param1 as Bitmap).bitmapData,"auto",true);
         _figure.smoothing = true;
         Helpers.scaleDisplayObject(_figure,null,null,70);
         _figure.x = 3;
         _figure.y = 7;
         _figure.mask = _mask;
         addChild(_figure);
         addChild(_mask);
      }
      
      private function __characterComplete(param1:Event) : void
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
            _figure.scaleX = 0.45 * (_directrion == "left"?1:-1);
            _figure.scaleY = 0.45;
            _figure.x = _directrion == "left"?0:82;
            _figure.y = 7;
         }
         else
         {
            _figure = new Bitmap(new BitmapData(200,200));
            _figure.bitmapData.copyPixels(_character.characterBitmapdata,new Rectangle(0,10,200,200),new Point(0,0));
            _figure.scaleX = 0.35 * (_directrion == "left"?1:-1);
            _figure.scaleY = 0.35;
            _figure.x = _directrion == "left"?0:73;
            _figure.y = 5;
         }
         addChild(_figure);
      }
      
      public function dispose() : void
      {
         _info = null;
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
         _mask = null;
         ObjectUtils.disposeObject(_iconBg);
         _iconBg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
