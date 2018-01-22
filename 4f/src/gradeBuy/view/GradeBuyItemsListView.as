package gradeBuy.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.TimeManager;
   import ddt.utils.HelperHelpBtnCreate;
   import ddt.utils.Helpers;
   import gradeBuy.GradeBuyManager;
   import gradeBuy.ICountDown;
   
   public class GradeBuyItemsListView extends Frame implements ICountDown
   {
       
      
      private var _itemList:Vector.<GradeBuyItem>;
      
      private var _remainTimeDetailTxt:FilterFrameText;
      
      private var _remainTimeTxt:FilterFrameText;
      
      private var _info:ItemTemplateInfo;
      
      private var _data:Object;
      
      private var _detailString:String;
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _helpBtnHelper:HelperHelpBtnCreate;
      
      public function GradeBuyItemsListView(){super();}
      
      override protected function init() : void{}
      
      protected function onBuyClick(param1:CEvent) : void{}
      
      private function _response(param1:FrameEvent) : void{}
      
      public function setData(param1:ItemTemplateInfo, param2:Object) : void{}
      
      public function update() : void{}
      
      override public function dispose() : void{}
   }
}
