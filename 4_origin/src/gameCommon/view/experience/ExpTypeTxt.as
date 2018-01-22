package gameCommon.view.experience
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class ExpTypeTxt extends Sprite implements Disposeable
   {
      
      public static const FIGHTING_EXP:String = "fightingExp";
      
      public static const ATTATCH_EXP:String = "attatchExp";
      
      public static const EXPLOIT_EXP:String = "exploitExp";
       
      
      private var _grayTxt:Bitmap;
      
      private var _lightTxt:Bitmap;
      
      private var _valueTxt:FilterFrameText;
      
      private var _value:Number;
      
      private var _idx:int;
      
      private var _type:String;
      
      private var _movie:MovieClip;
      
      public function ExpTypeTxt(param1:String, param2:int, param3:Number = 0)
      {
         super();
         _idx = param2;
         _type = param1;
         _value = param3;
         init();
      }
      
      protected function init() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = _type;
         if("fightingExp" !== _loc2_)
         {
            if("attatchExp" !== _loc2_)
            {
               if("exploitExp" === _loc2_)
               {
                  _grayTxt = ComponentFactory.Instance.creatBitmap("asset.experience.exploitExpItemTxt_a" + String(_idx));
                  _lightTxt = ComponentFactory.Instance.creatBitmap("asset.experience.exploitExpItemTxt_b" + String(_idx));
                  _valueTxt = ComponentFactory.Instance.creatComponentByStylename("experience.exploitTypeTxt");
               }
            }
            else
            {
               if(_idx == 7)
               {
                  _movie = ComponentFactory.Instance.creat("asset.expView.goForPowerMovieAsset");
                  _loc1_ = ComponentFactory.Instance.creatCustomObject("gameOver.goForPowerPosition");
                  _movie.x = _loc1_.x;
                  _movie.y = _loc1_.y;
               }
               else if(_idx == 8)
               {
                  _grayTxt = ComponentFactory.Instance.creatBitmap("asset.experience.exploitExpItemTxt_a4");
                  _lightTxt = ComponentFactory.Instance.creatBitmap("asset.experience.attachExpItemTxt_b" + String(_idx));
               }
               else
               {
                  _grayTxt = ComponentFactory.Instance.creatBitmap("asset.experience.attachExpItemTxt_a" + String(_idx));
                  _lightTxt = ComponentFactory.Instance.creatBitmap("asset.experience.attachExpItemTxt_b" + String(_idx));
               }
               _valueTxt = ComponentFactory.Instance.creatComponentByStylename("experience.expTypeTxt");
            }
         }
         else
         {
            _grayTxt = ComponentFactory.Instance.creatBitmap("asset.experience.fightExpItemTxt_a" + String(_idx));
            _lightTxt = ComponentFactory.Instance.creatBitmap("asset.experience.fightExpItemTxt_b" + String(_idx));
            _valueTxt = ComponentFactory.Instance.creatComponentByStylename("experience.expTypeTxt");
         }
         if(_valueTxt)
         {
            _valueTxt.alpha = 0;
         }
         if(_grayTxt)
         {
            addChild(_grayTxt);
         }
         if(value)
         {
            ExpTweenManager.Instance.appendTween(TweenLite.to(_valueTxt,0.15,{
               "y":"-30",
               "alpha":1,
               "onStart":play
            }));
            ExpTweenManager.Instance.appendTween(TweenLite.to(_valueTxt,0.3,{
               "y":"-20",
               "alpha":0,
               "delay":0.1
            }));
         }
      }
      
      public function play() : void
      {
         SoundManager.instance.play("142");
         if(_type == "attatchExp" && _idx == 7)
         {
            _valueTxt.visible = false;
            if(_movie)
            {
               addChild(_movie);
               _movie.play();
            }
         }
         else
         {
            addChild(_lightTxt);
            addChild(_valueTxt);
            _grayTxt.parent.removeChild(_grayTxt);
            if(value < 0)
            {
               _valueTxt.text = String(value) + "  ";
            }
            else
            {
               _valueTxt.text = "+" + String(value) + "  ";
            }
         }
         dispatchEvent(new Event("change"));
      }
      
      public function get value() : Number
      {
         return _value;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_lightTxt);
         ObjectUtils.disposeObject(_valueTxt);
         _lightTxt = null;
         _valueTxt = null;
         if(_grayTxt)
         {
            ObjectUtils.disposeObject(_grayTxt);
            _grayTxt = null;
         }
         ObjectUtils.disposeObject(_movie);
         _movie = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
