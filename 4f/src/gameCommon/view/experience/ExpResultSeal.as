package gameCommon.view.experience
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class ExpResultSeal extends Sprite implements Disposeable
   {
      
      public static const WIN:String = "win";
      
      public static const LOSE:String = "lose";
       
      
      private var _luckyShapes:Vector.<DisplayObject>;
      
      private var _luckyExp:Boolean;
      
      private var _luckyOffer:Boolean;
      
      private var _bitmap:Bitmap;
      
      private var _starMc:MovieClip;
      
      private var _effectMc:MovieClip;
      
      private var _result:String;
      
      public function ExpResultSeal(param1:String = "lose", param2:Boolean = false, param3:Boolean = false){super();}
      
      protected function init() : void{}
      
      public function dispose() : void{}
   }
}
