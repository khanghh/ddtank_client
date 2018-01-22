package guardCore.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import guardCore.GuardCoreManager;
   import guardCore.data.GuardCoreInfo;
   
   public class GuardCoreTips extends BaseTip
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _name:FilterFrameText;
      
      private var _describe:FilterFrameText;
      
      private var _keepTurn:FilterFrameText;
      
      private var _next:FilterFrameText;
      
      private var _nextGrade:FilterFrameText;
      
      private var _nextDescribe:FilterFrameText;
      
      private var _nextKeepTurn:FilterFrameText;
      
      private var _type:int;
      
      private var _grade:int;
      
      private var _guardGrade:int;
      
      private var _vBox:VBox;
      
      private const RED:uint = 16711680;
      
      private const GREEN:uint = 1895424;
      
      public function GuardCoreTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("guardCore.TipsBg");
         addChild(_bg);
         _vBox = ComponentFactory.Instance.creatComponentByStylename("guardCore.tipsVBox");
         addChild(_vBox);
         _name = ComponentFactory.Instance.creatComponentByStylename("guardCore.tipsName");
         _describe = ComponentFactory.Instance.creatComponentByStylename("guardCore.tipsDescribe");
         _keepTurn = ComponentFactory.Instance.creatComponentByStylename("guardCore.tipsDescribe");
         _next = ComponentFactory.Instance.creatComponentByStylename("guardCore.tipsNext");
         _next.text = LanguageMgr.GetTranslation("guardCore.tipsNext");
         _nextGrade = ComponentFactory.Instance.creatComponentByStylename("guardCore.tipsName");
         _nextDescribe = ComponentFactory.Instance.creatComponentByStylename("guardCore.tipsDescribe");
         _nextKeepTurn = ComponentFactory.Instance.creatComponentByStylename("guardCore.tipsDescribe");
         super.init();
      }
      
      private function updateView() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         _vBox.disposeAllChildren();
         if(GuardCoreManager.instance.getGuardCoreIsOpen(_grade,_type))
         {
            _loc2_ = GuardCoreManager.instance.getGuardCoreInfo(_guardGrade,_type);
            _loc1_ = GuardCoreManager.instance.getGuardCoreInfoBySkillGrade(_loc2_.SkillGrade + 1,_type);
            _name.text = _loc2_.Name;
            _describe.text = LanguageMgr.GetTranslation("guardCore.tipsGuardEffect",_loc2_.Description);
            if(_loc2_.KeepTurn == 0)
            {
               _keepTurn.text = LanguageMgr.GetTranslation("guardCore.tipsKeepTurnForever");
            }
            else
            {
               _keepTurn.text = LanguageMgr.GetTranslation("guardCore.tipsKeepTurn",_loc2_.KeepTurn);
            }
            _vBox.addChild(_name);
            _vBox.addChild(getLine());
            _vBox.addChild(_describe);
            _vBox.addChild(_keepTurn);
            _vBox.addChild(getLine());
            _vBox.addChild(_next);
            if(_loc1_ == null)
            {
               _nextDescribe.text = LanguageMgr.GetTranslation("guardCore.tipsMaxGrade");
               _vBox.addChild(_nextDescribe);
            }
            else
            {
               _nextGrade.text = LanguageMgr.GetTranslation("guardCore.tipsNeedGuard",_loc1_.GuardGrade);
               _nextGrade.textColor = 16711680;
               _nextDescribe.text = LanguageMgr.GetTranslation("guardCore.tipsGuardEffect",_loc1_.Description);
               if(_loc1_.KeepTurn == 0)
               {
                  _nextKeepTurn.text = LanguageMgr.GetTranslation("guardCore.tipsKeepTurnForever");
               }
               else
               {
                  _nextKeepTurn.text = LanguageMgr.GetTranslation("guardCore.tipsKeepTurn",_loc1_.KeepTurn);
               }
               _vBox.addChild(_nextGrade);
               _vBox.addChild(_nextDescribe);
               _vBox.addChild(_nextKeepTurn);
            }
         }
         else
         {
            _loc2_ = GuardCoreManager.instance.getGuardCoreInfoBySkillGrade(1,_type);
            _name.text = _loc2_.Name;
            _describe.text = LanguageMgr.GetTranslation("guardCore.tipsNotOpen");
            _nextGrade.text = LanguageMgr.GetTranslation("guardCore.tipsNeedGrade",_loc2_.GainGrade);
            _nextGrade.textColor = 16711680;
            _nextDescribe.text = LanguageMgr.GetTranslation("guardCore.tipsGuardEffect",_loc2_.Description);
            if(_loc2_.KeepTurn == 0)
            {
               _nextKeepTurn.text = LanguageMgr.GetTranslation("guardCore.tipsKeepTurnForever");
            }
            else
            {
               _nextKeepTurn.text = LanguageMgr.GetTranslation("guardCore.tipsKeepTurn",_loc2_.KeepTurn);
            }
            _vBox.addChild(_name);
            _vBox.addChild(getLine());
            _vBox.addChild(_describe);
            _vBox.addChild(getLine());
            _vBox.addChild(_next);
            _vBox.addChild(_nextGrade);
            _vBox.addChild(_nextDescribe);
            _vBox.addChild(_nextKeepTurn);
         }
         resetTextSize(_describe);
         resetTextSize(_nextDescribe);
         _vBox.arrange();
         _bg.height = _vBox.height + _vBox.y + 8;
         this.width = _bg.width;
         this.height = _bg.height;
      }
      
      private function resetTextSize(param1:FilterFrameText) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(param1.textWidth > 160)
         {
            _loc4_ = param1.getCharIndexAtPoint(160,23);
            _loc3_ = param1.text.substring(0,_loc4_);
            _loc2_ = param1.text.substring(_loc4_,param1.text.length);
            param1.text = _loc3_ + "\n" + _loc2_;
         }
      }
      
      override public function set tipData(param1:Object) : void
      {
         if(_type == param1.type && _grade == param1.grade && _guardGrade == param1.guardGrade)
         {
            return;
         }
         _tipData = param1;
         _type = param1.type;
         _grade = param1.grade;
         _guardGrade = param1.guardGrade;
         updateView();
      }
      
      private function getLine() : Image
      {
         var _loc1_:Image = ComponentFactory.Instance.creatComponentByStylename("HRuleAsset");
         _loc1_.width = 160;
         return _loc1_;
      }
      
      override public function get tipData() : Object
      {
         return _tipData;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         super.dispose();
      }
   }
}
