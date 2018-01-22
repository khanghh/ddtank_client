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
      
      public function set rankingInfos(param1:Vector.<RankingPersonInfo>) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(param1 == null)
         {
            return;
         }
         var _loc2_:int = 1;
         var _loc7_:int = 0;
         var _loc6_:* = param1;
         for each(var _loc5_ in param1)
         {
            _loc2_++;
            _loc3_ = new RankingPersonInfoItem(_loc2_,_loc5_,true);
            _loc4_ = ComponentFactory.Instance.creatCustomObject("worldbossAward.rankingItemSize");
            _container.addChild(_loc3_);
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
