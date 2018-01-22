package fightLib.view
{
   import com.pickgliss.effect.AddMovieEffect;
   import com.pickgliss.effect.EffectManager;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class LessonButton extends Sprite implements Disposeable
   {
      
      public static const hitCommands:Vector.<int> = Vector.<int>([1,2,2,2,2,2]);
      
      public static const hitCoords:Vector.<Number> = Vector.<Number>([52,1,115,3,117,21,91,94,24,88,20,67]);
      
      public static const SelectedLesson:String = "SelectedLesson";
       
      
      private var _type:int = -1;
      
      private var _enabled:Boolean = true;
      
      private var _background:DisplayObject;
      
      private var _icon:DisplayObject;
      
      private var _label:DisplayObject;
      
      private var _hitShape:Sprite;
      
      private var _lastIcon:DisplayObject;
      
      private var _lastLabel:DisplayObject;
      
      private var _labelString:String;
      
      private var _iconString:String;
      
      private var _shine:Boolean;
      
      private var _selected:Boolean = false;
      
      private var _shineEffect:IEffect;
      
      private var _selectedBitmap:Bitmap;
      
      private var _mesIdx:String;
      
      public function LessonButton(){super();}
      
      private static function createShineEffect(param1:LessonButton) : IEffect{return null;}
      
      public function dispose() : void{}
      
      public function set mesIdx(param1:String) : void{}
      
      public function get mesIdx() : String{return null;}
      
      public function get enabled() : Boolean{return false;}
      
      public function set enabled(param1:Boolean) : void{}
      
      public function set icon(param1:String) : void{}
      
      public function get icon() : String{return null;}
      
      public function set label(param1:String) : void{}
      
      public function get label() : String{return null;}
      
      public function get type() : int{return 0;}
      
      public function set type(param1:int) : void{}
      
      public function get selected() : Boolean{return false;}
      
      public function set selected(param1:Boolean) : void{}
      
      public function get shine() : Boolean{return false;}
      
      public function set shine(param1:Boolean) : void{}
      
      public function setIcon(param1:DisplayObject) : void{}
      
      public function setLabel(param1:DisplayObject) : void{}
      
      private function configUI() : void{}
      
      private function __mouseOver(param1:MouseEvent) : void{}
      
      private function __mouseOut(param1:MouseEvent) : void{}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function drawHit() : void{}
      
      private function __clicked(param1:MouseEvent) : void{}
   }
}
