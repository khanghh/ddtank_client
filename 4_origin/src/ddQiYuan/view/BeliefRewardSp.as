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
         var item:* = null;
         var i:int = 0;
         var model:DDQiYuanModel = DDQiYuanManager.instance.model;
         _beliefRewardOfferTimesTf = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.beliefRewardOfferTimesTf");
         addChild(_beliefRewardOfferTimesTf);
         _list = new VBox();
         _list.spacing = 3;
         var beliefConfigArr:Array = model.beliefConfigArr;
         for(i = 0; i < beliefConfigArr.length; )
         {
            item = new BeliefRewardListItem();
            item.setData(beliefConfigArr[i]);
            _list.addChild(item);
            i++;
         }
         _panel = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.beliefRewardScrollPanel");
         _panel.setView(_list);
         addChild(_panel);
         _panel.invalidateViewport();
      }
      
      public function update() : void
      {
         var model:DDQiYuanModel = DDQiYuanManager.instance.model;
         _beliefRewardOfferTimesTf.text = LanguageMgr.GetTranslation("ddQiYuan.frame.beliefRewardOfferTimesTfMsg",model.myOfferTimes);
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
