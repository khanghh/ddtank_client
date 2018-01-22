package gemstone.items
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.text.TextFormat;
   import gemstone.info.GemstoneTipVO;
   
   public class GemstoneLeftViewTip extends BaseTip
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _tempData:Object;
      
      private var _titleTxt:FilterFrameText;
      
      private var _curPropertyTxt:FilterFrameText;
      
      private var _nextTxt:FilterFrameText;
      
      private var _nextPropertyTxt:FilterFrameText;
      
      private var _line1:Image;
      
      private var _line2:Image;
      
      public function GemstoneLeftViewTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("gemstone.tipBG");
         this.tipbackgound = _bg;
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("gemstone.tipTxt1");
         addChild(_titleTxt);
         _line1 = ComponentFactory.Instance.creatComponentByStylename("gemstone.line1");
         addChild(_line1);
         _curPropertyTxt = ComponentFactory.Instance.creatComponentByStylename("gemstone.tipTxt2");
         addChild(_curPropertyTxt);
         _line2 = ComponentFactory.Instance.creatComponentByStylename("gemstone.line2");
         addChild(_line2);
         _nextTxt = ComponentFactory.Instance.creatComponentByStylename("gemstone.nextTxt");
         _nextTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.nextLevel");
         addChild(_nextTxt);
         _nextPropertyTxt = ComponentFactory.Instance.creatComponentByStylename("gemstone.tipTxt3");
         addChild(_nextPropertyTxt);
      }
      
      override public function set tipData(param1:Object) : void
      {
         _tempData = param1;
         if(!_tempData)
         {
            return;
         }
         updateView();
      }
      
      override public function get tipData() : Object
      {
         return _tempData;
      }
      
      private function updateView() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         var _loc5_:GemstoneTipVO = _tempData as GemstoneTipVO;
         var _loc4_:String = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.GoldenAddAttack");
         var _loc3_:String = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.GoldenReduceDamage");
         switch(int(_loc5_.gemstoneType) - 1)
         {
            case 0:
               _loc2_ = ComponentFactory.Instance.model.getSet("gemstone.Tip.TF5");
               _loc1_ = ComponentFactory.Instance.model.getSet("gemstone.Tip.TF5");
               if(_loc5_.level == 6)
               {
                  _titleTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.goldenGemstone");
                  _curPropertyTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.AtcAdd",_loc5_.increase + _loc4_);
               }
               else
               {
                  _titleTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.redGemstoneAtc2",_loc5_.level);
                  _curPropertyTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.AtcAdd",_loc5_.increase);
               }
               if(_loc5_.level + 1 == 6)
               {
                  _nextPropertyTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.AtcAdd",_loc5_.nextIncrease + _loc4_);
               }
               else
               {
                  _nextPropertyTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.AtcAdd",_loc5_.nextIncrease);
               }
               break;
            case 1:
               _loc2_ = ComponentFactory.Instance.model.getSet("gemstone.Tip.TF6");
               _loc1_ = ComponentFactory.Instance.model.getSet("gemstone.Tip.TF6");
               if(_loc5_.level == 6)
               {
                  _titleTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.goldenGemstone");
                  _curPropertyTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.DefAdd",_loc5_.increase + _loc3_);
               }
               else
               {
                  _titleTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.bluGemstoneDef2",_loc5_.level);
                  _curPropertyTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.DefAdd",_loc5_.increase);
               }
               if(_loc5_.level + 1 == 6)
               {
                  _nextPropertyTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.DefAdd",_loc5_.nextIncrease + _loc3_);
               }
               else
               {
                  _nextPropertyTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.DefAdd",_loc5_.nextIncrease);
               }
               break;
            case 2:
               _loc2_ = ComponentFactory.Instance.model.getSet("gemstone.Tip.TF7");
               _loc1_ = ComponentFactory.Instance.model.getSet("gemstone.Tip.TF7");
               if(_loc5_.level == 6)
               {
                  _titleTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.goldenGemstone");
                  _curPropertyTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.AgiAdd",_loc5_.increase + _loc4_);
               }
               else
               {
                  _titleTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.greGemstoneAgi2",_loc5_.level);
                  _curPropertyTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.AgiAdd",_loc5_.increase);
               }
               if(_loc5_.level + 1 == 6)
               {
                  _nextPropertyTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.AgiAdd",_loc5_.nextIncrease + _loc4_);
               }
               else
               {
                  _nextPropertyTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.AgiAdd",_loc5_.nextIncrease);
               }
               break;
            case 3:
               _loc2_ = ComponentFactory.Instance.model.getSet("gemstone.Tip.TF8");
               _loc1_ = ComponentFactory.Instance.model.getSet("gemstone.Tip.TF8");
               if(_loc5_.level == 6)
               {
                  _titleTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.goldenGemstone");
                  _curPropertyTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.LukAdd",_loc5_.increase + _loc3_);
               }
               else
               {
                  _titleTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.yelGemstoneLuk2",_loc5_.level);
                  _curPropertyTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.LukAdd",_loc5_.increase);
               }
               if(_loc5_.level + 1 == 6)
               {
                  _nextPropertyTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.LukAdd",_loc5_.nextIncrease + _loc3_);
               }
               else
               {
                  _nextPropertyTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.LukAdd",_loc5_.nextIncrease);
               }
               break;
            case 4:
               _loc2_ = ComponentFactory.Instance.model.getSet("gemstone.Tip.TF8_1");
               _loc1_ = ComponentFactory.Instance.model.getSet("gemstone.Tip.TF8_1");
               if(_loc5_.level == 6)
               {
                  _titleTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.goldenGemstone");
                  _curPropertyTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.BloodAdd",_loc5_.increase + _loc3_);
               }
               else
               {
                  _titleTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.purpleGemstoneLuk2",_loc5_.level);
                  _curPropertyTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.BloodAdd",_loc5_.increase);
               }
               if(_loc5_.level + 1 == 6)
               {
                  _nextPropertyTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.BloodAdd",_loc5_.nextIncrease + _loc3_);
                  break;
               }
               _nextPropertyTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.BloAdd",_loc5_.nextIncrease);
               break;
         }
         if(_loc5_.level == 0)
         {
            _curPropertyTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.inactive");
         }
         if(_loc5_.level >= 6)
         {
            _nextPropertyTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.fullLevel");
         }
         _titleTxt.setTextFormat(_loc2_);
         _curPropertyTxt.setTextFormat(_loc2_);
         _nextPropertyTxt.setTextFormat(_loc1_);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_titleTxt);
         _titleTxt = null;
         ObjectUtils.disposeObject(_curPropertyTxt);
         _curPropertyTxt = null;
         ObjectUtils.disposeObject(_nextTxt);
         _nextTxt = null;
         ObjectUtils.disposeObject(_nextPropertyTxt);
         _nextPropertyTxt = null;
         ObjectUtils.disposeObject(_line1);
         _line1 = null;
         ObjectUtils.disposeObject(_line2);
         _line2 = null;
         super.dispose();
      }
   }
}
