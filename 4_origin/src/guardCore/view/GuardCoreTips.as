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
         var info:* = null;
         var nextInfo:* = null;
         _vBox.disposeAllChildren();
         if(GuardCoreManager.instance.getGuardCoreIsOpen(_grade,_type))
         {
            info = GuardCoreManager.instance.getGuardCoreInfo(_guardGrade,_type);
            nextInfo = GuardCoreManager.instance.getGuardCoreInfoBySkillGrade(info.SkillGrade + 1,_type);
            _name.text = info.Name;
            _describe.text = LanguageMgr.GetTranslation("guardCore.tipsGuardEffect",info.Description);
            if(info.KeepTurn == 0)
            {
               _keepTurn.text = LanguageMgr.GetTranslation("guardCore.tipsKeepTurnForever");
            }
            else
            {
               _keepTurn.text = LanguageMgr.GetTranslation("guardCore.tipsKeepTurn",info.KeepTurn);
            }
            _vBox.addChild(_name);
            _vBox.addChild(getLine());
            _vBox.addChild(_describe);
            _vBox.addChild(_keepTurn);
            _vBox.addChild(getLine());
            _vBox.addChild(_next);
            if(nextInfo == null)
            {
               _nextDescribe.text = LanguageMgr.GetTranslation("guardCore.tipsMaxGrade");
               _vBox.addChild(_nextDescribe);
            }
            else
            {
               _nextGrade.text = LanguageMgr.GetTranslation("guardCore.tipsNeedGuard",nextInfo.GuardGrade);
               _nextGrade.textColor = 16711680;
               _nextDescribe.text = LanguageMgr.GetTranslation("guardCore.tipsGuardEffect",nextInfo.Description);
               if(nextInfo.KeepTurn == 0)
               {
                  _nextKeepTurn.text = LanguageMgr.GetTranslation("guardCore.tipsKeepTurnForever");
               }
               else
               {
                  _nextKeepTurn.text = LanguageMgr.GetTranslation("guardCore.tipsKeepTurn",nextInfo.KeepTurn);
               }
               _vBox.addChild(_nextGrade);
               _vBox.addChild(_nextDescribe);
               _vBox.addChild(_nextKeepTurn);
            }
         }
         else
         {
            info = GuardCoreManager.instance.getGuardCoreInfoBySkillGrade(1,_type);
            _name.text = info.Name;
            _describe.text = LanguageMgr.GetTranslation("guardCore.tipsNotOpen");
            _nextGrade.text = LanguageMgr.GetTranslation("guardCore.tipsNeedGrade",info.GainGrade);
            _nextGrade.textColor = 16711680;
            _nextDescribe.text = LanguageMgr.GetTranslation("guardCore.tipsGuardEffect",info.Description);
            if(info.KeepTurn == 0)
            {
               _nextKeepTurn.text = LanguageMgr.GetTranslation("guardCore.tipsKeepTurnForever");
            }
            else
            {
               _nextKeepTurn.text = LanguageMgr.GetTranslation("guardCore.tipsKeepTurn",info.KeepTurn);
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
      
      private function resetTextSize(text:FilterFrameText) : void
      {
         var p:int = 0;
         var str1:* = null;
         var str2:* = null;
         if(text.textWidth > 160)
         {
            p = text.getCharIndexAtPoint(160,23);
            str1 = text.text.substring(0,p);
            str2 = text.text.substring(p,text.text.length);
            text.text = str1 + "\n" + str2;
         }
      }
      
      override public function set tipData(value:Object) : void
      {
         if(_type == value.type && _grade == value.grade && _guardGrade == value.guardGrade)
         {
            return;
         }
         _tipData = value;
         _type = value.type;
         _grade = value.grade;
         _guardGrade = value.guardGrade;
         updateView();
      }
      
      private function getLine() : Image
      {
         var line:Image = ComponentFactory.Instance.creatComponentByStylename("HRuleAsset");
         line.width = 160;
         return line;
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
