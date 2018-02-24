package ddt.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.Helpers;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   
   public class DoubleSelectedItem extends Sprite implements IEventDispatcher
   {
      
      public static const BIND_TYPE:String = "bind";
      
      public static const NO_BIND_TYPE:String = "noBind";
      
      public static const EACH_TYPE:String = "each";
      
      private static const NOBIND:int = 1;
      
      private static const BIND:int = 0;
       
      
      private var _isBind:Boolean;
      
      private var _selectedBandBtn:SelectedCheckButton;
      
      private var _selectedBtn:SelectedCheckButton;
      
      private var _group1:SelectedButtonGroup;
      
      private var _bandMoneyTxt:FilterFrameText;
      
      private var _moneyTxt:FilterFrameText;
      
      private var _back:MovieClip;
      
      public function DoubleSelectedItem(){super();}
      
      public function useMoneyType(param1:String) : void{}
      
      public function lockMoneyType(param1:String) : void{}
      
      private function initView() : void{}
      
      private function initEvents() : void{}
      
      private function changeHander(param1:Event) : void{}
      
      public function get isBind() : Boolean{return false;}
      
      public function dispose() : void{}
   }
}
