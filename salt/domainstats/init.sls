# Copyright 2014,2015,2016,2017,2018,2019,2020 Security Onion Solutions, LLC

#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Create the group
dstatsgroup:
  group.present:
    - name: domainstats
    - gid: 936

# Add user
domainstats:
  user.present:
    - uid: 936
    - gid: 936
    - home: /opt/so/conf/domainstats
    - createhome: False

# Create the log directory
dstatslogdir:
  file.directory:
    - name: /opt/so/log/domainstats
    - user: 936
    - group: 939
    - makedirs: True

so-domainstatsimage:
 cmd.run:
   - name: docker pull --disable-content-trust=false docker.io/soshybridhunter/so-domainstats:HH1.0.3

so-domainstats:
  docker_container.running:
    - require:
      - so-domainstatsimage
    - image: docker.io/soshybridhunter/so-domainstats:HH1.0.3
    - hostname: domainstats
    - name: so-domainstats
    - user: domainstats
    - binds:
      - /opt/so/log/domainstats:/var/log/domain_stats
