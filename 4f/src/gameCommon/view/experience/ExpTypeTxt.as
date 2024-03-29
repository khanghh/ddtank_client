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
      
      public function ExpTypeTxt(param1:String, param2:int, param3:Number = 0){super();}
      
      protected function init() : void{}
      
      public function play() : void{}
      
      public function get value() : Number{return 0;}
      
      public function dispose() : void{}
   }
}
