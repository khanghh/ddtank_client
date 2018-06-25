package worldboss.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.geom.Rectangle;
   import worldboss.player.RankingPersonInfo;
   
   public class WorldBossRankingView extends Component
   {
       
      
      private var _titleBg:Bitmap;
      
      private var _container:VBox;
      
      public function WorldBossRankingView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _container = ComponentFactory.Instance.creatComponentByStylename("worldBossAward.rankingView.vbox");
         addChild(_container);
      }
      
      public function set rankingInfos(val:Vector.<RankingPersonInfo>) : void
      {
         var item:* = null;
         var size:* = null;
         if(val == null)
         {
            return;
         }
         var no:int = 1;
         var _loc7_:int = 0;
         var _loc6_:* = val;
         for each(var info in val)
         {
            no++;
            item = new RankingPersonInfoItem(no,info,true);
            size = ComponentFactory.Instance.creatCustomObject("worldbossAward.rankingItemSize");
            _container.addChild(item);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeObject(_container);
         _container = null;
      }
   }
}
