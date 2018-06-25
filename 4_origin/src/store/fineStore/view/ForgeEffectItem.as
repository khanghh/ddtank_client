package store.fineStore.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   
   public class ForgeEffectItem extends Sprite implements Disposeable
   {
       
      
      private var _titleText:FilterFrameText;
      
      private var _content:Component;
      
      private var _stateText:FilterFrameText;
      
      public function ForgeEffectItem(type:int, value:String, dataList:Array, state:int)
      {
         var i:int = 0;
         var text:* = null;
         super();
         var image:Image = ComponentFactory.Instance.creatComponentByStylename("fineSuit.tips.image");
         PositionUtils.setPos(image,"storeFine.tipsImagePos");
         addChild(image);
         image.setFrame(type + 1);
         _content = ComponentFactory.Instance.creatComponentByStylename("storeFine.effect.titleContent");
         addChild(_content);
         _titleText = ComponentFactory.Instance.creatComponentByStylename("storeFine.effect.titleText");
         _titleText.text = value;
         _content.addChild(_titleText);
         for(i = 0; i < dataList.length; )
         {
            text = UICreatShortcut.creatAndAdd("storeFine.effect.contentText",this);
            text.x = i % 2 == 0?32:Number(130);
            text.y = Math.ceil((i + 1) / 2) * 19;
            text.text = dataList[i];
            addChild(text);
            i++;
         }
         updateTipData();
         creatStateText(state);
      }
      
      private function creatStateText(state:int) : void
      {
         if(state > 0)
         {
            if(_stateText)
            {
               ObjectUtils.disposeObject(_stateText);
               _stateText = null;
            }
            _stateText = ComponentFactory.Instance.creatComponentByStylename("storeFine.cell.stateText" + state);
            _stateText.text = LanguageMgr.GetTranslation("storeFine.forge.state" + state);
            addChild(_stateText);
         }
      }
      
      public function updateTipData(state:int = 0) : void
      {
         _content.tipData = PlayerManager.Instance.Self.fineSuitExp;
         creatStateText(state);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_titleText);
         _titleText = null;
         ObjectUtils.disposeObject(_stateText);
         _stateText = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}
