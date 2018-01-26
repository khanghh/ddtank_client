package ddt.manager
{
   import com.pickgliss.ui.controls.BaseButton;
   import ddt.data.PyramidModel;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PyramidEvent;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import hall.HallStateView;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class PyramidManager extends EventDispatcher
   {
      
      private static var _instance:PyramidManager;
       
      
      private var _model:PyramidModel;
      
      private var _isShowIcon:Boolean = false;
      
      private var _pyramidBtn:BaseButton;
      
      private var _hall:HallStateView;
      
      public function PyramidManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : PyramidManager{return null;}
      
      public function setup() : void{}
      
      public function templateDataSetup(param1:Array) : void{}
      
      private function pkgHandler(param1:CrazyTankSocketEvent) : void{}
      
      protected function iconEnter(param1:PackageIn) : void{}
      
      private function openOrclose(param1:PackageIn) : void{}
      
      public function onClickPyramidIcon(param1:MouseEvent) : void{}
      
      public function showEnterIcon() : void{}
      
      protected function __onPyramidClick(param1:MouseEvent) : void{}
      
      public function hideEnterIcon() : void{}
      
      public function get model() : PyramidModel{return null;}
      
      public function get pyramidBtn() : BaseButton{return null;}
   }
}
