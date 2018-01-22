package ddt.view.buff.buffButton
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.data.BuffInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.RandomSuitCardManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import flash.events.MouseEvent;
   
   public class RandomSuitButton extends BuffButton
   {
       
      
      public function RandomSuitButton(){super(null);}
      
      override protected function __onMouseOver(param1:MouseEvent) : void{}
      
      override protected function __onMouseOut(param1:MouseEvent) : void{}
      
      override protected function __onclick(param1:MouseEvent) : void{}
      
      override protected function __onBuyResponse(param1:FrameEvent) : void{}
      
      override protected function onCheckComplete() : void{}
      
      override public function dispose() : void{}
   }
}
