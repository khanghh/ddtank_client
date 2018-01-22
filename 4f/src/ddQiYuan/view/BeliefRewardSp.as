package ddQiYuan.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddQiYuan.DDQiYuanManager;
   import ddQiYuan.model.DDQiYuanModel;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   
   public class BeliefRewardSp extends Sprite implements Disposeable
   {
       
      
      private var _beliefRewardOfferTimesTf:FilterFrameText;
      
      private var _itemList:Vector.<BeliefRewardListItem>;
      
      private var _list:VBox;
      
      private var _panel:ScrollPanel;
      
      public function BeliefRewardSp(){super();}
      
      private function initView() : void{}
      
      public function update() : void{}
      
      public function dispose() : void{}
   }
}
