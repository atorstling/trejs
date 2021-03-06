require 'formula'

# From https://gist.github.com/2bits/1848282
class Fakechroot < Formula
  desc ''
  homepage 'https://github.com/fakechroot/fakechroot/wiki'
  url 'https://github.com/downloads/fakechroot/fakechroot/fakechroot-2.16.tar.gz'
  sha256 '81c105e0878b55fbcf430235badcb31249d86ac435297910f411d9955dadf9c6'
  license ''

  def install
    inreplace 'src/__opendir2.c', '__FBSDID', '//__FBSDID'
    inreplace 'src/__opendir2.c', 'dd_td', '__dd_td'
    inreplace 'src/__opendir2.c', 'dd_buf', '__dd_buf'
    inreplace 'src/__opendir2.c', 'dd_fd', '__dd_fd'
    inreplace 'src/__opendir2.c', 'dd_loc', '__dd_loc'
    inreplace 'src/__opendir2.c', 'dd_size', '__dd_size'
    inreplace 'src/__opendir2.c', 'dd_len', '__dd_len'
    inreplace 'src/__opendir2.c', 'dd_seek', '__dd_seek'
    inreplace 'src/__opendir2.c', 'dd_rewind', '__dd_rewind'
    inreplace 'src/__opendir2.c', 'dd_flags', '__dd_flags'
    inreplace 'src/__opendir2.c', 'dirp->__dd_lock = NULL;',
                'pthread_mutex_init(dirp->__dd_lock, NULL);'
    inreplace 'src/__opendir2.c', 'dirp->__dd_rewind = telldir(dirp);',
      '//dirp->__dd_rewind = telldir(dirp);'
    inreplace 'src/ftw.c', '# define FTW_FUNC_T __ftw_func_t',
      'typedef int (*FTW_FUNC_T) (const char *, const struct stat *, int);'
    inreplace 'src/ftw.c', '# define NFTW_FUNC_T __nftw_func_t',
      'typedef int (*NFTW_FUNC_T) (const char *, const struct stat *, int, struct FTW *);'
    inreplace 'src/ftw.c', 'FTW_STOP', '1'
    inreplace 'src/ftw.c', 'FTW_SKIP_SUBTREE', '2'
    inreplace 'src/ftw.c', 'FTW_SKIP_SIBLINGS', '3'
    inreplace 'src/ftw.c', 'FTW_ACTIONRETVAL', '16'
    inreplace 'src/statfs64.c', '#include <sys/statfs.h>', "#include <sys/param.h>\n#include <sys/mount.h>"
    system "./configure", "--disable-silent-rules", "--prefix=#{prefix}"
    system "make -j 1"
    system "make install"
  end
end
