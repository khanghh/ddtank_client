package campbattle.view.rank
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class CampRankItem extends Component implements Disposeable
   {
       
      
      private var _scoreTxt:FilterFrameText;
      
      private var _manNumTxt:FilterFrameText;
      
      private var sp:Sprite;
      
      public function CampRankItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         sp = new Sprite();
         sp.graphics.beginFill(0);
         sp.graphics.drawRect(0,0,180,28);
         sp.graphics.endFill();
         sp.alpha = 0;
         sp.x = -83;
         sp.y = -5;
         addChild(sp);
         tipStyle = "ddt.view.tips.OneLineTip";
         tipDirctions = "5,1,2";
         tipGapH = -50;
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("ddtCampBattle.rankItemTxt");
         _scoreTxt.text = "";
         _scoreTxt.autoSize = "center";
         addChild(_scoreTxt);
         _manNumTxt = ComponentFactory.Instance.creatComponentByStylename("ddtCampBattle.rankItemTxt");
         _manNumTxt.x = 63;
         _manNumTxt.text = "";
         _manNumTxt.autoSize = "center";
         addChild(_manNumTxt);
      }
      
      public function setItemTxt(obj:Object) : void
      {
         _scoreTxt.text = obj.score;
         _manNumTxt.text = obj.roles + "/15";
      }
      
      public function resetItemTxt() : void
      {
         _scoreTxt.text = "";
         _manNumTxt.text = "";
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_scoreTxt);
         ObjectUtils.disposeObject(_manNumTxt);
         super.dispose();
      }
   }
}
