package gameCommon.view.playerThumbnail
{
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PathManager;
   import ddt.view.character.ShowCharacter;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import gameCommon.GameControl;
   import gameCommon.model.Living;
   import gameCommon.model.Player;
   import gameCommon.model.SimpleBoss;
   
   public class HeadFigure extends Sprite implements Disposeable
   {
       
      
      private var _head:Bitmap;
      
      private var _headC:Sprite;
      
      private var _info:Player;
      
      private var _width:Number;
      
      private var _height:Number;
      
      private var _living:Living;
      
      private var _defaultFace:BitmapData;
      
      private var _isGray:Boolean = false;
      
      private var _displayLoader:DisplayLoader;
      
      public function HeadFigure(param1:Number, param2:Number, param3:Object = null)
      {
         super();
         _defaultFace = ComponentFactory.Instance.creatBitmapData("game.player.gameCharacter");
         if(param3 is Player)
         {
            _info = param3 as Player;
            if(_info && _info.character)
            {
               (_info.character as ShowCharacter).addEventListener("complete",bitmapChange);
            }
         }
         else
         {
            _living = param3 as Living;
            _living.addEventListener("complete",bitmapChange);
         }
         _width = param1;
         _height = param2;
         initFigure();
         this.width = param1;
         this.height = param2;
      }
      
      private function initFigure() : void
      {
         var _loc1_:* = null;
         if(_living)
         {
            initLivingHead();
         }
         else
         {
            _loc1_ = _info.character as ShowCharacter;
            if(_info && _loc1_ && _loc1_.characterBitmapdata)
            {
               drawHead(_loc1_.characterBitmapdata);
            }
            else if(_info && _loc1_ && !_loc1_.characterBitmapdata)
            {
               drawHead(_defaultFace);
            }
         }
      }
      
      private function initLivingHead() : void
      {
         if(GameControl.Instance.is3DGame)
         {
            _headC = new Sprite();
            addChild(_headC);
            _headC.graphics.beginFill(0,0);
            _headC.graphics.drawRect(0,0,61,61);
            _headC.graphics.endFill();
            _displayLoader = LoadResourceManager.Instance.createLoader(PathManager.getBoneLivingHeadPath(_living.actionBonesMovieName),0);
            _displayLoader.addEventListener("complete",__onLoaderComplete);
            LoadResourceManager.Instance.startLoad(_displayLoader);
         }
         else
         {
            _head = new Bitmap(_living.thumbnail.clone(),"auto",true);
            addChild(_head);
         }
      }
      
      private function __onLoaderComplete(param1:LoaderEvent) : void
      {
         _displayLoader.removeEventListener("complete",__onLoaderComplete);
         if(param1.loader.isSuccess)
         {
            _headC.addChild(param1.loader.content as Bitmap);
         }
      }
      
      private function bitmapChange(param1:Event) : void
      {
         if(!_info || !_info.character)
         {
            return;
         }
         drawHead((_info.character as ShowCharacter).characterBitmapdata);
         if(_isGray)
         {
            gray();
         }
      }
      
      private function drawHead(param1:BitmapData) : void
      {
         if(param1 == null)
         {
            return;
         }
         ObjectUtils.disposeObject(_head);
         _head = new Bitmap(new BitmapData(_width,_height,true,0),"auto",true);
         var _loc3_:Rectangle = getHeadRect();
         var _loc2_:Matrix = new Matrix();
         _loc2_.identity();
         _loc2_.scale(_width / _loc3_.width,_height / _loc3_.height);
         _loc2_.translate(-_loc3_.x * (_width / _loc3_.width),-_loc3_.y * (_height / _loc3_.height));
         _head.bitmapData.draw(param1,_loc2_);
         addChild(_head);
      }
      
      private function getHeadRect() : Rectangle
      {
         if(_info == null)
         {
            if(_living is SimpleBoss)
            {
               return new Rectangle(0,0,300,300);
            }
            return new Rectangle(-2,-2,80,80);
         }
         if(_info.playerInfo.getSuitsType() == 1)
         {
            return new Rectangle(21,12,167,165);
         }
         return new Rectangle(16,58,170,170);
      }
      
      public function gray() : void
      {
         if(_head)
         {
            _head.filters = [new ColorMatrixFilter([0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0])];
         }
         if(_headC)
         {
            _headC.filters = [new ColorMatrixFilter([0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0])];
         }
         _isGray = true;
      }
      
      public function reset() : void
      {
         if(_head)
         {
            _head.filters = null;
         }
         if(_headC)
         {
            _headC.filters = null;
         }
         _isGray = false;
      }
      
      public function dispose() : void
      {
         if(_info)
         {
            if(_info.character)
            {
               (_info.character as ShowCharacter).removeEventListener("complete",bitmapChange);
            }
         }
         if(_displayLoader)
         {
            _displayLoader.removeEventListener("complete",__onLoaderComplete);
         }
         _displayLoader = null;
         ObjectUtils.disposeAllChildren(_headC);
         ObjectUtils.disposeObject(_headC);
         ObjectUtils.disposeObject(_head);
         _living = null;
         _headC = null;
         _head = null;
         _info = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
