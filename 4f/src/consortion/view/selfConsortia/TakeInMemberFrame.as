package consortion.view.selfConsortia
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import consortion.ConsortionModelManager;
   import consortion.data.ConsortiaApplyInfo;
   import consortion.event.ConsortionEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class TakeInMemberFrame extends Frame
   {
       
      
      private var _bg:MovieImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _levelTxt:FilterFrameText;
      
      private var _powerTxt:FilterFrameText;
      
      private var _operateTxt:FilterFrameText;
      
      private var _level:TextButton;
      
      private var _power:TextButton;
      
      private var _selectAll:TextButton;
      
      private var _agree:TextButton;
      
      private var _refuse:TextButton;
      
      private var _setRefuse:SelectedCheckButton;
      
      private var _refuseImg:FilterFrameText;
      
      private var _takeIn:TextButton;
      
      private var _close:TextButton;
      
      private var _list:VBox;
      
      private var _lastSort:String;
      
      private var _items:Array;
      
      private var _turnPage:TakeInTurnPage;
      
      private var _itemBG:MutipleImage;
      
      private var _menberListVLine:MutipleImage;
      
      private var _powerBtn:Sprite;
      
      private var _levelBtn:Sprite;
      
      private var _pageCount:int = 8;
      
      public function TakeInMemberFrame(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __pageChangeHandler(param1:Event) : void{}
      
      private function __consortiaApplyStatusResult(param1:PkgEvent) : void{}
      
      private function __refishListHandler(param1:ConsortionEvent) : void{}
      
      private function clearList() : void{}
      
      private function setList(param1:Vector.<ConsortiaApplyInfo>) : void{}
      
      private function sort(param1:String) : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      private function __clickHandler(param1:MouseEvent) : void{}
      
      private function selectAll() : void{}
      
      private function allHasSelected() : Boolean{return false;}
      
      private function agree() : void{}
      
      private function refuse() : void{}
      
      override public function dispose() : void{}
   }
}
