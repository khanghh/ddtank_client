package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   import pet.data.PetSkillTemplateInfo;
   import road7th.utils.StringHelper;
   
   public class PetSkillCellTip extends BaseTip
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var name_txt:FilterFrameText;
      
      private var ballType_txt:FilterFrameText;
      
      private var _lostLbl:FilterFrameText;
      
      private var _lostTxt:FilterFrameText;
      
      private var _descLbl:FilterFrameText;
      
      private var _descTxt:FilterFrameText;
      
      private var _coolDownTxt:FilterFrameText;
      
      private var _splitImg:ScaleBitmapImage;
      
      private var _splitImg2:ScaleBitmapImage;
      
      private var _tempData:PetSkillTemplateInfo;
      
      private var _container:Sprite;
      
      private var LEADING:int = 5;
      
      public function PetSkillCellTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         name_txt = ComponentFactory.Instance.creat("petsBag.PetSkillCellTip.name");
         ballType_txt = ComponentFactory.Instance.creat("core.petskillTip.ballTypeTxt");
         _lostLbl = ComponentFactory.Instance.creat("petsBag.PetSkillCellTip.lostLbl");
         _lostLbl.text = LanguageMgr.GetTranslation("ddt.pets.skillTipLost");
         _lostTxt = ComponentFactory.Instance.creat("petsBag.PetSkillCellTip.lostTxt");
         _descLbl = ComponentFactory.Instance.creat("petsBag.PetSkillCellTip.descLbl");
         _descLbl.text = LanguageMgr.GetTranslation("ddt.pets.skillTipDesc");
         _descTxt = ComponentFactory.Instance.creat("petsBag.PetSkillCellTip.descTxt");
         _coolDownTxt = ComponentFactory.Instance.creat("petsBag.PetSkillCellTip.coolDownTxt");
         _bg = ComponentFactory.Instance.creat("core.GoodsTipBg");
         _splitImg = ComponentFactory.Instance.creatComponentByStylename("petTips.line");
         _splitImg2 = ComponentFactory.Instance.creatComponentByStylename("petTips.line");
         _container = new Sprite();
         _container.addChild(name_txt);
         _container.addChild(ballType_txt);
         _container.addChild(_lostLbl);
         _container.addChild(_lostTxt);
         _container.addChild(_descLbl);
         _container.addChild(_descTxt);
         _container.addChild(_coolDownTxt);
         _container.addChild(_splitImg);
         _container.addChild(_splitImg2);
         super.init();
         this.tipbackgound = _bg;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         addChild(_container);
         _container.mouseEnabled = false;
         _container.mouseChildren = false;
         this.mouseChildren = false;
         this.mouseEnabled = false;
      }
      
      override public function get tipData() : Object
      {
         return _tempData;
      }
      
      override public function set tipData(param1:Object) : void
      {
         _tempData = param1 as PetSkillTemplateInfo;
         if(!_tempData)
         {
            return;
         }
         updateView();
      }
      
      private function updateView() : void
      {
         name_txt.text = StringHelper.trim(_tempData.Name) + "(" + (!!_tempData.isActiveSkill?LanguageMgr.GetTranslation("core.petskillTip.activeSkill"):LanguageMgr.GetTranslation("core.petskillTip.passiveSkill")) + ")";
         if(_tempData.isActiveSkill)
         {
            ballType_txt.text = LanguageMgr.GetTranslation("core.petskillTip.balltype" + _tempData.BallType);
         }
         else
         {
            ballType_txt.text = "";
         }
         _lostTxt.text = LanguageMgr.GetTranslation("ddt.pets.skillTipMagicValue",_tempData.CostMP);
         _descTxt.text = _tempData.Description;
         if(_tempData.isActiveSkill)
         {
            _coolDownTxt.text = LanguageMgr.GetTranslation("tank.game.actions.cooldown") + ": " + _tempData.ColdDown + LanguageMgr.GetTranslation("tank.game.actions.turn");
         }
         else
         {
            _coolDownTxt.text = LanguageMgr.GetTranslation("tank.game.actions.cooldown") + ": 0" + LanguageMgr.GetTranslation("tank.game.actions.turn");
         }
         fixPos();
         _bg.width = _container.width + 15;
         _bg.height = _container.height + 15;
         _width = _bg.width;
         _height = _bg.height;
      }
      
      private function fixPos() : void
      {
         ballType_txt.x = name_txt.x;
         ballType_txt.y = name_txt.y + name_txt.textHeight + LEADING * 2;
         _splitImg.y = ballType_txt.y + ballType_txt.textHeight + LEADING;
         _lostLbl.y = _splitImg.y + _splitImg.height + LEADING;
         _lostLbl.x = ballType_txt.x;
         _lostTxt.x = _lostLbl.x + _lostLbl.textWidth + LEADING;
         _lostTxt.y = _lostLbl.y;
         _descLbl.x = ballType_txt.x;
         _descLbl.y = _lostTxt.y + _lostTxt.textHeight + LEADING;
         _descTxt.x = _descLbl.x + _descLbl.textWidth + LEADING;
         _descTxt.y = _descLbl.y;
         _splitImg2.y = _descTxt.y + _descTxt.textHeight + LEADING * 2;
         _coolDownTxt.x = ballType_txt.x;
         _coolDownTxt.y = _splitImg2.y + _splitImg2.height + LEADING;
      }
      
      override public function dispose() : void
      {
         _tempData = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_container)
         {
            ObjectUtils.disposeObject(_container);
            _container = null;
         }
         if(_splitImg2)
         {
            ObjectUtils.disposeObject(_splitImg2);
            _splitImg2 = null;
         }
         if(_splitImg)
         {
            ObjectUtils.disposeObject(_splitImg);
            _splitImg = null;
         }
         if(_descTxt)
         {
            ObjectUtils.disposeObject(_descTxt);
            _descTxt = null;
         }
         if(_coolDownTxt)
         {
            ObjectUtils.disposeObject(_coolDownTxt);
            _coolDownTxt = null;
         }
         if(name_txt)
         {
            ObjectUtils.disposeObject(name_txt);
            name_txt = null;
         }
         if(_lostLbl)
         {
            ObjectUtils.disposeObject(_lostLbl);
            _lostLbl = null;
         }
         if(_lostTxt)
         {
            ObjectUtils.disposeObject(_lostTxt);
            _lostTxt = null;
         }
         if(_descLbl)
         {
            ObjectUtils.disposeObject(_descLbl);
            _descLbl = null;
         }
         if(ballType_txt)
         {
            ObjectUtils.disposeObject(ballType_txt);
            ballType_txt = null;
         }
      }
   }
}
