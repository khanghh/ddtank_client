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
      
      public function BeliefRewardSp()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc1_:DDQiYuanModel = DDQiYuanManager.instance.model;
         _beliefRewardOfferTimesTf = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.beliefRewardOfferTimesTf");
         addChild(_beliefRewardOfferTimesTf);
         _list = new VBox();
         _list.spacing = 3;
         var _loc3_:Array = _loc1_.beliefConfigArr;
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc2_ = new BeliefRewardListItem();
            _loc2_.setData(_loc3_[_loc4_]);
            _list.addChild(_loc2_);
            _loc4_++;
         }
         _panel = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.beliefRewardScrollPanel");
         _panel.setView(_list);
         addChild(_panel);
         _panel.invalidateViewport();
      }
      
      public function update() : void
      {
         var _loc1_:DDQiYuanModel = DDQiYuanManager.instance.model;
         _beliefRewardOfferTimesTf.text = LanguageMgr.GetTranslation("ddQiYuan.frame.beliefRewardOfferTimesTfMsg",_loc1_.myOfferTimes);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _beliefRewardOfferTimesTf = null;
         _itemList = null;
         _list = null;
         _panel = null;
      }
   }
}
