package calendar.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.DaylyGiveInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   
   public class SignAwardFrame extends BaseAlerFrame
   {
       
      
      private var _back:DisplayObject;
      
      private var _awardCells:Vector.<SignAwardCell>;
      
      private var _awards:Array;
      
      private var _signCount:int;
      
      public function SignAwardFrame(){super();}
      
      private function __response(param1:FrameEvent) : void{}
      
      public function show(param1:int, param2:Array) : void{}
      
      private function configUI() : void{}
      
      override public function dispose() : void{}
   }
}
