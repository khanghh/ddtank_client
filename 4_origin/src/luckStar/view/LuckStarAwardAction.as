package luckStar.view
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import luckStar.manager.LuckStarManager;
   
   public class LuckStarAwardAction extends Sprite implements Disposeable
   {
       
      
      private var _action:MovieClip;
      
      private var _list:Vector.<Bitmap>;
      
      private var _cell:Function;
      
      private var _num:Vector.<ScaleFrameImage>;
      
      private var _count:int = 0;
      
      private var len:int;
      
      private var arr:Array;
      
      private var _isMaxAward:Boolean;
      
      private var _mc:MovieClip;
      
      private var _image:Bitmap;
      
      private var _content:Sprite;
      
      private var _move:Point;
      
      private var _tweenMax:TweenMax;
      
      public function LuckStarAwardAction()
      {
         arr = [9,99,999,9999,99999,999999,9999999];
         super();
      }
      
      public function playAction(param1:Function, param2:DisplayObject, param3:Point, param4:Boolean = false) : void
      {
         _cell = param1;
         _isMaxAward = param4;
         if(_isMaxAward)
         {
            playMaxAwardAction();
            return;
         }
         _content = new Sprite();
         addChild(_content);
         _image = param2 as Bitmap;
         _move = param3;
         var _loc5_:Rectangle = ComponentFactory.Instance.creatCustomObject("luckyStar.view.AwardLightRec");
         _mc = ComponentFactory.Instance.creat("luckyStar.view.TurnMC");
         _mc.stop();
         var _loc6_:* = _loc5_.width;
         _mc.height = _loc6_;
         _mc.width = _loc6_;
         _mc.x = _loc5_.x;
         _mc.y = _loc5_.y;
         _mc.gotoAndPlay(1);
         _mc.addEventListener("enterFrame",__onEnter);
         _content.addChild(_mc);
      }
      
      private function playNextAction() : void
      {
         if(_image)
         {
            var _loc1_:* = -2;
            _image.y = _loc1_;
            _image.x = _loc1_;
            _loc1_ = 0.8;
            _image.scaleY = _loc1_;
            _image.scaleX = _loc1_;
            _content.addChild(_image);
         }
      }
      
      private function __onEnter(param1:Event) : void
      {
         if(_mc.currentFrame == 40)
         {
            SoundManager.instance.play("125");
            playNextAction();
         }
         if(_mc.currentFrame == 65)
         {
            _tweenMax = TweenMax.to(_content,0.7,{
               "x":_move.x,
               "y":_move.y,
               "width":60,
               "height":60
            });
         }
         if(_mc.currentFrame == _mc.totalFrames - 1)
         {
            disposeAction();
         }
      }
      
      public function get actionDisplay() : Sprite
      {
         return _content;
      }
      
      private function disposeAction() : void
      {
         if(_mc)
         {
            _mc.stop();
            _mc.removeEventListener("enterFrame",__onEnter);
            ObjectUtils.disposeObject(_mc);
            _mc = null;
         }
         if(_image)
         {
            ObjectUtils.disposeObject(_image);
            _image = null;
         }
         if(_tweenMax)
         {
            TweenMax.killChildTweensOf(_content);
         }
         _tweenMax = null;
         ObjectUtils.disposeObject(_content);
         _content = null;
         if(_cell != null)
         {
            _cell.apply();
         }
         _cell = null;
      }
      
      public function playMaxAwardAction() : void
      {
         LayerManager.Instance.addToLayer(this,3,false,1);
         _list = new Vector.<Bitmap>();
         _num = new Vector.<ScaleFrameImage>();
         _count = LuckStarManager.Instance.model.coins;
         _action = ComponentFactory.Instance.creat("luckyStar.view.maxAwardAction");
         PositionUtils.setPos(_action,"luckyStar.view.maxAwardActionPos");
         addChild(_action);
         _action.addEventListener("enterFrame",__onAction);
         _action.gotoAndPlay(1);
         SoundManager.instance.play("210");
      }
      
      private function setupCount() : void
      {
         var _loc3_:int = 0;
         while(len > _num.length)
         {
            _num.unshift(createCoinsNum(0));
         }
         while(len < _num.length)
         {
            ObjectUtils.disposeObject(_num.shift());
         }
         var _loc2_:int = 8 - len;
         var _loc1_:int = _loc2_ / 2 * 25;
         _loc3_ = 0;
         while(_loc3_ < len)
         {
            _num[_loc3_].x = _loc1_ + 280;
            _num[_loc3_].y = 200;
            _loc1_ = _loc1_ + 25;
            _loc3_++;
         }
      }
      
      private function playCount() : void
      {
         setupCount();
         if(len == 0 || len > arr.length)
         {
            return;
         }
         var _loc1_:int = Math.random() * int(arr[len - 1]);
         updateCoinsView(_loc1_.toString().split(""));
      }
      
      private function updateCoinsView(param1:Array) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < len)
         {
            if(param1[_loc2_] == 0)
            {
               param1[_loc2_] = 10;
            }
            _num[_loc2_].setFrame(param1[_loc2_]);
            _loc2_++;
         }
      }
      
      private function __onAction(param1:Event) : void
      {
         updateCoinsView(_count.toString().split(""));
         if(_action.currentFrame < 165)
         {
            if(_action.currentFrame % 20 == 0)
            {
               len = Number(len) + 1;
               if(len > _count.toString().length)
               {
                  len = _count.toString().length;
               }
               SoundManager.instance.play("210");
            }
            playCount();
            coinsDrop();
         }
         checkDrop();
         if(_action.currentFrame == _action.totalFrames - 1)
         {
            len = 0;
            _action.stop();
            _action.removeEventListener("enterFrame",__onAction);
            _action = null;
            if(_cell != null)
            {
               _cell.apply();
            }
            _cell = null;
         }
      }
      
      private function coinsDrop() : void
      {
         var _loc1_:int = Math.random() * 3;
         var _loc2_:Bitmap = ComponentFactory.Instance.creatBitmap("luckyStar.view.CoinsRain" + _loc1_);
         _loc2_.x = Math.random() * 700 + 100;
         _list.push(_loc2_);
         addChildAt(_loc2_,0);
      }
      
      private function checkDrop() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _list.length)
         {
            _list[_loc1_].y = _list[_loc1_].y + 30;
            if(_list[_loc1_].y > 500)
            {
               ObjectUtils.disposeObject(_list[_loc1_]);
               _list.splice(_list.indexOf(_list[_loc1_]),_list.indexOf(_list[_loc1_]));
            }
            _loc1_++;
         }
      }
      
      private function createCoinsNum(param1:int = 0) : ScaleFrameImage
      {
         var _loc2_:ScaleFrameImage = ComponentFactory.Instance.creatComponentByStylename("luckyStar.view.CoinsNum");
         _loc2_.setFrame(param1);
         if(_action)
         {
            _action.addChild(_loc2_);
         }
         return _loc2_;
      }
      
      public function dispose() : void
      {
         while(_list && _list.length)
         {
            ObjectUtils.disposeObject(_list.pop());
         }
         _list = null;
         while(_num && _num.length)
         {
            ObjectUtils.disposeObject(_num.pop());
         }
         _num = null;
         _cell = null;
         if(_action)
         {
            _action.stop();
            _action.removeEventListener("enterFrame",__onAction);
         }
         _action = null;
      }
   }
}
