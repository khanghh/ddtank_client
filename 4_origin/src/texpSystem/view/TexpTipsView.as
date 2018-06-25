package texpSystem.view
{
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import morn.core.components.Label;
   import texpSystem.controller.TexpManager;
   import texpSystem.data.TexpInfo;
   import texpSystem.view.mornui.TexpTipsViewUI;
   
   public class TexpTipsView extends BaseTip
   {
       
      
      private var _tipsUI:TexpTipsViewUI;
      
      public function TexpTipsView()
      {
         super();
         _tipsUI = new TexpTipsViewUI();
         addChild(_tipsUI);
         updateView();
      }
      
      private function updateView() : void
      {
         var i:int = 0;
         var info:* = null;
         for(i = 0; i < 14; )
         {
            info = TexpManager.Instance.getInfo(i,TexpManager.Instance.getExp(i));
            (_tipsUI["texpLabel" + i] as Label).text = "+" + info.currEffect.toString();
            i++;
         }
      }
      
      override public function set tipData(value:Object) : void
      {
         .super.tipData = value;
         updateView();
      }
      
      override public function get width() : Number
      {
         return _tipsUI.width;
      }
      
      override public function get height() : Number
      {
         return _tipsUI.height;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_tipsUI);
         _tipsUI = null;
         super.dispose();
      }
   }
}
