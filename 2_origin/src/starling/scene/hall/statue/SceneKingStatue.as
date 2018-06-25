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
      
      public function SceneKingStatue(type:int)
      {
         super();
         touchable = false;
         _type = type;
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
         var assetName:* = null;
         var vipImage:* = null;
         var girlAttest:* = null;
         var nameWidth:* = 0;
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
         var bg:Sprite = new Sprite();
         _nameSprite.addChild(bg);
         var textWidth:Number = FilterFrameText.getStringWidthByTextField(_info.name,15);
         var nameText:TextField = new TextField(textWidth,20,_info.name,"Arial",14,6155281,true);
         nameText.vAlign = "top";
         nameText.x = 5;
         _nameSprite.addChild(nameText);
         nameWidth = Number(nameWidth + (textWidth + 10));
         if(_info.IsVIP)
         {
            assetName = "image_vipGrade_small" + _info.vipLevel;
            vipImage = StarlingMain.instance.createImage(assetName);
            vipImage.x = 5;
            vipImage.y = -10;
            _nameSprite.addChild(vipImage);
            nameText.color = 16116007;
            nameText.x = vipImage.width + 5;
            nameWidth = Number(nameWidth + (vipImage.width + 5));
         }
         if(_info.isAttest)
         {
            girlAttest = StarlingMain.instance.createImage("image_player_girlAttest");
            _nameSprite.addChild(girlAttest);
            girlAttest.x = nameWidth;
            girlAttest.y = -5;
            nameWidth = Number(nameWidth + (girlAttest.width + 5));
         }
         bg.graphics.beginFill(0,0.5);
         bg.graphics.drawRect(0,0,nameWidth,20);
         bg.graphics.endFill();
         _nameSprite.x = 60 - nameWidth / 2;
      }
      
      public function set info(info:BKingStatueInfo) : void
      {
         var playerInfo:* = null;
         var characterLoader:* = null;
         _info = info;
         if(_info.name != null && _info.name != "")
         {
            createPlayerName();
            playerInfo = new PlayerInfo();
            playerInfo.Style = info.style;
            playerInfo.Colors = info.color;
            playerInfo.Sex = info.sex;
            characterLoader = CharactoryFactory.createCharacter(playerInfo) as ShowCharacter;
            characterLoader.addEventListener("complete",__characterComplete);
            characterLoader.showGun = true;
            characterLoader.setShowLight(false,null);
            characterLoader.stopAnimation();
            characterLoader.show(true,1);
         }
      }
      
      private function __characterComplete(event:Event) : void
      {
         var figure:* = null;
         if(_isDispose)
         {
            return;
         }
         var loader:ShowCharacter = event.target as ShowCharacter;
         loader.removeEventListener("complete",__characterComplete);
         figure = new Bitmap(new BitmapData(250,320));
         figure.bitmapData.copyPixels(loader.characterBitmapdata,new Rectangle(0,0,250,320),new Point(0,0));
         figure.scaleX = RANK_SCALE[_info.rank];
         figure.scaleY = RANK_SCALE[_info.rank];
         figure.smoothing = true;
         figure.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         var reliefBitmap:Bitmap = ComponentFactory.Instance.creat("bombKing.role.relief" + _type);
         reliefBitmap.blendMode = "hardlight";
         var figureData:BitmapData = figure.bitmapData.clone();
         figureData.applyFilter(figureData,new Rectangle(0,0,figure.width,figure.height),new Point(0,0),new ColorMatrixFilter([0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0,0,0,1,0]));
         var relief:Tile = new Tile(figureData,true);
         PositionUtils.setPos(relief,figure);
         relief.scaleX = figure.scaleX;
         relief.scaleY = figure.scaleY;
         relief.Dig(new Point(figure.width / 2 + 50,figure.height - 45),null,reliefBitmap);
         relief.alpha = 0.4;
         var textureData:BitmapData = new BitmapData(250,320,true,0);
         textureData.copyPixels(figure.bitmapData,new Rectangle(0,0,250,320),new Point(0,0));
         textureData.draw(relief,null,null,"overlay");
         StarlingObjectUtils.disposeObject(_image,true);
         _image = new Image(Texture.fromBitmapData(textureData,false));
         _image.scaleX = figure.scaleX;
         _image.scaleY = figure.scaleY;
         addChild(_image);
         figure.bitmapData.dispose();
         reliefBitmap.bitmapData.dispose();
         figureData.dispose();
         relief.dispose();
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
