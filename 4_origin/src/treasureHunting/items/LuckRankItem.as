package treasureHunting.items
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class LuckRankItem extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleFrameImage;
      
      private var _selectedBg:ScaleLeftRightImage;
      
      private var _sortText:FilterFrameText;
      
      private var _nameText:FilterFrameText;
      
      private var _numberText:FilterFrameText;
      
      public function LuckRankItem(param1:int)
      {
         super();
         initView(param1);
      }
      
      private function initView(param1:int) : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("treasreHunting.rankItemBG");
         _selectedBg = ComponentFactory.Instance.creatComponentByStylename("treasureHunting.ScaleLeftRightImage1");
         _selectedBg.visible = false;
         _sortText = ComponentFactory.Instance.creatComponentByStylename("treasureHunting.Luck.sortTxt");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("treasureHunting.Luck.NameTxt");
         _numberText = ComponentFactory.Instance.creatComponentByStylename("treasureHunting.Luck.NumberTxt");
         _bg.setFrame(param1 % 2 + 1);
         addChild(_bg);
         addChild(_selectedBg);
         addChild(_sortText);
         addChild(_nameText);
         addChild(_numberText);
      }
      
      public function update(param1:int, param2:String, param3:int) : void
      {
         _bg.setFrame(param1 % 2 + 1);
         _sortText.text = param1 + 1 + "th";
         _nameText.text = param2;
         _numberText.text = param3.toString();
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selectedBg.visible = param1;
      }
      
      public function dispose() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_selectedBg)
         {
            ObjectUtils.disposeObject(_selectedBg);
         }
         _selectedBg = null;
         if(_sortText)
         {
            ObjectUtils.disposeObject(_sortText);
         }
         _sortText = null;
         if(_nameText)
         {
            ObjectUtils.disposeObject(_nameText);
         }
         _nameText = null;
         if(_numberText)
         {
            ObjectUtils.disposeObject(_numberText);
         }
         _numberText = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
