package totem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.events.CEvent;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import totem.TotemManager;
   import totem.data.TotemDataVo;
   
   public class TotemInfoView extends Sprite implements Disposeable
   {
       
      
      private var _windowView:TotemLeftWindowActiveView;
      
      private var _levelBg:Bitmap;
      
      private var _level:FilterFrameText;
      
      private var _txtBg:Bitmap;
      
      private var _propertyList:Vector.<TotemInfoViewTxtCell>;
      
      private var _info:PlayerInfo;
      
      private var _chapterIcon:TotemItemTabView;
      
      public function TotemInfoView(info:PlayerInfo)
      {
         super();
         _info = info;
         initView();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var tmp:* = null;
         var totemVo:TotemDataVo = TotemManager.instance.getCurInfoById(_info.totemId);
         var totemNextVo:TotemDataVo = TotemManager.instance.getNextInfoById(_info.totemId);
         _windowView = new TotemLeftWindowActiveView();
         PositionUtils.setPos(_windowView,"totem.leftView.windowActivePos");
         _windowView.show(totemVo.Page,totemNextVo,false);
         _windowView.scaleX = 0.792349726775956;
         _windowView.scaleY = 0.792349726775956;
         _windowView.scalePropertyTxtSprite(1.26206896551724);
         _chapterIcon = new TotemItemTabView(_info,1);
         PositionUtils.setPos(_chapterIcon,"totem.leftView.chapterOtherPlayerPos");
         _chapterIcon.selectedPage = totemVo.Page;
         _chapterIcon.curTotemPagePrecess = totemNextVo == null?totemVo.Page:int(totemNextVo.Page);
         _levelBg = ComponentFactory.Instance.creatBitmap("asset.totem.infoView.levelBg");
         _level = ComponentFactory.Instance.creatComponentByStylename("totem.infoView.level.txt");
         _txtBg = ComponentFactory.Instance.creatBitmap("asset.totem.infoView.txtBg");
         addChild(_windowView);
         addChild(_chapterIcon);
         addChild(_levelBg);
         addChild(_level);
         _level.text = TotemManager.instance.getCurrentLv(TotemManager.instance.getTotemPointLevel(_info.totemId)).toString();
         addChild(_txtBg);
         _propertyList = new Vector.<TotemInfoViewTxtCell>();
         for(i = 1; i <= 7; )
         {
            tmp = ComponentFactory.Instance.creatCustomObject("TotemInfoViewTxtCell" + i,[_info]);
            tmp.show(i,_info.totemId);
            addChild(tmp);
            _propertyList.push(tmp);
            tmp.x = _propertyList[0].x + (i - 1) % 4 * 104;
            tmp.y = _propertyList[0].y + int((i - 1) / 4) * 32;
            i++;
         }
      }
      
      private function __changeChapterHandler(evt:CEvent) : void
      {
         var temIndex:int = evt.data;
         var totemVo:TotemDataVo = TotemManager.instance.getCurInfoById(_info.totemId);
         var totemNextVo:TotemDataVo = TotemManager.instance.getNextInfoById(_info.totemId);
         _windowView.show(totemVo.Page,totemNextVo,false);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         if(_windowView)
         {
            _windowView.dispose();
         }
         _windowView = null;
         if(_chapterIcon)
         {
            _chapterIcon.dispose();
         }
         _chapterIcon = null;
         _levelBg = null;
         _level = null;
         _txtBg = null;
         _propertyList = null;
         _info = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
