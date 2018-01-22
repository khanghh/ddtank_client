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
      
      public function ForgeEffectItem(param1:int, param2:String, param3:Array, param4:int)
      {
         var _loc7_:int = 0;
         var _loc5_:* = null;
         super();
         var _loc6_:Image = ComponentFactory.Instance.creatComponentByStylename("fineSuit.tips.image");
         PositionUtils.setPos(_loc6_,"storeFine.tipsImagePos");
         addChild(_loc6_);
         _loc6_.setFrame(param1 + 1);
         _content = ComponentFactory.Instance.creatComponentByStylename("storeFine.effect.titleContent");
         addChild(_content);
         _titleText = ComponentFactory.Instance.creatComponentByStylename("storeFine.effect.titleText");
         _titleText.text = param2;
         _content.addChild(_titleText);
         _loc7_ = 0;
         while(_loc7_ < param3.length)
         {
            _loc5_ = UICreatShortcut.creatAndAdd("storeFine.effect.contentText",this);
            _loc5_.x = _loc7_ % 2 == 0?32:Number(130);
            _loc5_.y = Math.ceil((_loc7_ + 1) / 2) * 19;
            _loc5_.text = param3[_loc7_];
            addChild(_loc5_);
            _loc7_++;
         }
         updateTipData();
         creatStateText(param4);
      }
      
      private function creatStateText(param1:int) : void
      {
         if(param1 > 0)
         {
            if(_stateText)
            {
               ObjectUtils.disposeObject(_stateText);
               _stateText = null;
            }
            _stateText = ComponentFactory.Instance.creatComponentByStylename("storeFine.cell.stateText" + param1);
            _stateText.text = LanguageMgr.GetTranslation("storeFine.forge.state" + param1);
            addChild(_stateText);
         }
      }
      
      public function updateTipData(param1:int = 0) : void
      {
         _content.tipData = PlayerManager.Instance.Self.fineSuitExp;
         creatStateText(param1);
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
