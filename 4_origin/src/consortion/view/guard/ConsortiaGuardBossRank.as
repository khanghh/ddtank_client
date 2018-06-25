package consortion.view.guard
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.data.ConsortiaBossDataVo;
   import consortion.guard.ConsortiaGuardControl;
   import consortion.guard.ConsortiaGuardEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import road7th.data.DictionaryData;
   
   public class ConsortiaGuardBossRank extends Sprite implements Disposeable
   {
       
      
      private const selectX:int = 983;
      
      private const unSelectX:int = 787;
      
      private var _bg:ScaleBitmapImage;
      
      private var _selectBtn:SelectedCheckButton;
      
      private var _openShow:Boolean = true;
      
      private var _titleText:FilterFrameText;
      
      private var _nameVBox:VBox;
      
      private var _valueVBox:VBox;
      
      private var _nameList:Vector.<FilterFrameText>;
      
      private var _valueList:Vector.<FilterFrameText>;
      
      public function ConsortiaGuardBossRank()
      {
         super();
         init();
         initEvent();
      }
      
      private function init() : void
      {
         var i:int = 0;
         var name:* = null;
         var text:* = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortiaGuard.rankViewBg");
         addChild(_bg);
         _selectBtn = ComponentFactory.Instance.creatComponentByStylename("consortiaGuard.rankViewSelectBtn");
         addChild(_selectBtn);
         _titleText = ComponentFactory.Instance.creatComponentByStylename("consortiaGuard.rank.titleText");
         _titleText.text = LanguageMgr.GetTranslation("tank.consortiaGurad.rankTitleText");
         addChild(_titleText);
         _nameVBox = ComponentFactory.Instance.creatComponentByStylename("consortiaGuard.rank.nameVBox");
         addChild(_nameVBox);
         _valueVBox = ComponentFactory.Instance.creatComponentByStylename("consortiaGuard.rank.valueVBox");
         addChild(_valueVBox);
         _nameList = new Vector.<FilterFrameText>();
         _valueList = new Vector.<FilterFrameText>();
         for(i = 0; i < 10; )
         {
            name = ComponentFactory.Instance.creatComponentByStylename("consortiaGuard.rank.nameText");
            text = ComponentFactory.Instance.creatComponentByStylename("consortiaGuard.rank.rankText");
            _nameList.push(name);
            _valueList.push(text);
            _nameVBox.addChild(name);
            _valueVBox.addChild(text);
            i++;
         }
         this.x = 787;
         __onUpdateRank(null);
      }
      
      private function __onSelectClikc(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         updateRankPos();
      }
      
      private function updateRankPos() : void
      {
         var pos:int = 0;
         if(_selectBtn.selected)
         {
            pos = 983;
         }
         else
         {
            pos = 787;
         }
         TweenLite.killTweensOf(this,true);
         TweenLite.to(this,0.5,{"x":pos});
      }
      
      private function __onUpdateRank(e:ConsortiaGuardEvent) : void
      {
         var i:int = 0;
         var vo:* = null;
         var list:DictionaryData = ConsortiaGuardControl.Instance.model.rankList;
         for(i = 0; i < 10; )
         {
            vo = list[i + 1] as ConsortiaBossDataVo;
            if(vo)
            {
               _nameList[i].text = vo.rank + "." + vo.name;
               _valueList[i].text = vo.damage.toString();
            }
            else
            {
               _nameList[i].text = "";
               _valueList[i].text = "";
            }
            i++;
         }
         _nameVBox.arrange();
         _valueVBox.arrange();
      }
      
      private function initEvent() : void
      {
         _selectBtn.addEventListener("click",__onSelectClikc);
         ConsortiaGuardControl.Instance.addEventListener("updateRank",__onUpdateRank);
      }
      
      private function removeEvent() : void
      {
         _selectBtn.removeEventListener("click",__onSelectClikc);
         ConsortiaGuardControl.Instance.removeEventListener("updateRank",__onUpdateRank);
      }
      
      public function dispose() : void
      {
         removeEvent();
         TweenLite.killTweensOf(this);
         ObjectUtils.disposeObject(_nameVBox);
         ObjectUtils.disposeObject(_valueVBox);
         ObjectUtils.disposeAllChildren(this);
         _nameList = null;
         _valueList = null;
         _nameVBox = null;
         _valueVBox = null;
         _selectBtn = null;
         _bg = null;
      }
   }
}
