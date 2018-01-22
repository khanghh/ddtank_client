package starling.scene.hall.statue
{
   import bombKing.data.BKingStatueInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.StarlingObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.utils.PositionUtils;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.ShowCharacter;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import phy.maps.Tile;
   import road7th.StarlingMain;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.text.TextField;
   import starling.textures.Texture;
   
   public class SceneKingStatue extends Sprite
   {
      
      private static const RANK_SCALE:Array = [0.66,0.63,0.6];
       
      
      private var _type:int;
      
      private var _info:BKingStatueInfo;
      
      private var _image:Image;
      
      private var _nameSprite:Sprite;
      
      private var _title:Image;
      
      private var _isDispose:Boolean = false;
      
      public function SceneKingStatue(param1:int)
      {
         super();
         touchable = false;
         _type = param1;
         if(!int(_type))
         {
            _title = StarlingMain.instance.createImage("image_title_1001");
            _title.x = 60 - _title.width / 2;
            _title.y = -(_title.height + 5);
            addChild(_title);
         }
      }
      
      private function createPlayerName() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = 0;
         if(_nameSprite == null)
         {
            _nameSprite = new Sprite();
            _nameSprite.y = -4;
            addChild(_nameSprite);
         }
         else
         {
            StarlingObjectUtils.disposeAllChildren(_nameSprite);
         }
         var _loc4_:Sprite = new Sprite();
         _nameSprite.addChild(_loc4_);
         var _loc7_:Number = FilterFrameText.getStringWidthByTextField(_info.name,15);
         var _loc3_:TextField = new TextField(_loc7_,20,_info.name,"Arial",14,6155281,true);
         _loc3_.vAlign = "top";
         _loc3_.x = 5;
         _nameSprite.addChild(_loc3_);
         _loc6_ = Number(_loc6_ + (_loc7_ + 10));
         if(_info.IsVIP)
         {
            _loc1_ = "image_vipGrade_small" + _info.vipLevel;
            _loc2_ = StarlingMain.instance.createImage(_loc1_);
            _loc2_.x = 5;
            _loc2_.y = -10;
            _nameSprite.addChild(_loc2_);
            _loc3_.color = 16116007;
            _loc3_.x = _loc2_.width + 5;
            _loc6_ = Number(_loc6_ + (_loc2_.width + 5));
         }
         if(_info.isAttest)
         {
            _loc5_ = StarlingMain.instance.createImage("image_player_girlAttest");
            _nameSprite.addChild(_loc5_);
            _loc5_.x = _loc6_;
            _loc5_.y = -5;
            _loc6_ = Number(_loc6_ + (_loc5_.width + 5));
         }
         _loc4_.graphics.beginFill(0,0.5);
         _loc4_.graphics.drawRect(0,0,_loc6_,20);
         _loc4_.graphics.endFill();
         _nameSprite.x = 60 - _loc6_ / 2;
      }
      
      public function set info(param1:BKingStatueInfo) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         _info = param1;
         if(_info.name != null && _info.name != "")
         {
            createPlayerName();
            _loc2_ = new PlayerInfo();
            _loc2_.Style = param1.style;
            _loc2_.Colors = param1.color;
            _loc2_.Sex = param1.sex;
            _loc3_ = CharactoryFactory.createCharacter(_loc2_) as ShowCharacter;
            _loc3_.addEventListener("complete",__characterComplete);
            _loc3_.showGun = true;
            _loc3_.setShowLight(false,null);
            _loc3_.stopAnimation();
            _loc3_.show(true,1);
         }
      }
      
      private function __characterComplete(param1:Event) : void
      {
         var _loc3_:* = null;
         if(_isDispose)
         {
            return;
         }
         var _loc5_:ShowCharacter = param1.target as ShowCharacter;
         _loc5_.removeEventListener("complete",__characterComplete);
         _loc3_ = new Bitmap(new BitmapData(250,320));
         _loc3_.bitmapData.copyPixels(_loc5_.characterBitmapdata,new Rectangle(0,0,250,320),new Point(0,0));
         _loc3_.scaleX = RANK_SCALE[_info.rank];
         _loc3_.scaleY = RANK_SCALE[_info.rank];
         _loc3_.smoothing = true;
         _loc3_.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         var _loc2_:Bitmap = ComponentFactory.Instance.creat("bombKing.role.relief" + _type);
         _loc2_.blendMode = "hardlight";
         var _loc6_:BitmapData = _loc3_.bitmapData.clone();
         _loc6_.applyFilter(_loc6_,new Rectangle(0,0,_loc3_.width,_loc3_.height),new Point(0,0),new ColorMatrixFilter([0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0,0,0,1,0]));
         var _loc7_:Tile = new Tile(_loc6_,true);
         PositionUtils.setPos(_loc7_,_loc3_);
         _loc7_.scaleX = _loc3_.scaleX;
         _loc7_.scaleY = _loc3_.scaleY;
         _loc7_.Dig(new Point(_loc3_.width / 2 + 50,_loc3_.height - 45),null,_loc2_);
         _loc7_.alpha = 0.4;
         var _loc4_:BitmapData = new BitmapData(250,320,true,0);
         _loc4_.copyPixels(_loc3_.bitmapData,new Rectangle(0,0,250,320),new Point(0,0));
         _loc4_.draw(_loc7_,null,null,"overlay");
         StarlingObjectUtils.disposeObject(_image,true);
         _image = new Image(Texture.fromBitmapData(_loc4_,false));
         _image.scaleX = _loc3_.scaleX;
         _image.scaleY = _loc3_.scaleY;
         addChild(_image);
         _loc3_.bitmapData.dispose();
         _loc2_.bitmapData.dispose();
         _loc6_.dispose();
         _loc7_.dispose();
      }
      
      override public function dispose() : void
      {
         _isDispose = true;
         StarlingObjectUtils.disposeAllChildren(_nameSprite);
         StarlingObjectUtils.disposeObject(_nameSprite);
         StarlingObjectUtils.disposeObject(_image,true);
         StarlingObjectUtils.disposeObject(_title);
         super.dispose();
         _nameSprite = null;
         _image = null;
         _title = null;
      }
   }
}
